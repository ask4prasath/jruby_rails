module Rhea
  class OozieBuilder

    attr_accessor :pipeline_name, :name_node, :job_tracker, :user_name, :schedule, :actions, :pipeline_id

    def self.generate_files(workflow)
      workflow.data_ingestions.collect do |data_ingestion|
        action = {name: data_ingestion.name, id: data_ingestion.id, type: "data_ingestion", schedule: data_ingestion.schedule}
        OozieBuilder.new(data_ingestion.name, ENV["NAME_NODE"], ENV["JOB_TRACKER"], data_ingestion.schedule, [action], data_ingestion.id)
      end

    end

    def initialize(pipeline_name, name_node, job_tracker, schedule, actions, id)
      self.pipeline_name = pipeline_name
      self.name_node = name_node
      self.job_tracker = job_tracker
      self.schedule = JSON.parse schedule
      self.actions = actions
      self.pipeline_id = id
    end

    def save()
      directory_name = Rails.root.to_s + "/oozie" + "/" + self.pipeline_id.to_s + "/"
      FileUtils.mkdir_p directory_name
      File.open(directory_name + "coordinator.xml",  "w") {|file| file.write(self.get_coordinator_xml)}
      File.open(directory_name + "job.properties",  "w") {|file| file.write(self.get_job_properties)}
      File.open(directory_name + "workflow.xml",  "w") {|file| file.write(self.get_workflow)}
    end

    def submit
      #TODO
    end

    def build_path(list)
      list.collect { |action| "<path name=\"#{action["name"]}\"/>" }
    end

    def spark_type(action_type)
      case action_type
        when "data_ingestion"
          "Ingestion"
        when "data_curation"
          "Curation"
        when "data_curation_with_sink"
          "Curation with Sink"
      end

    end

    def build_actions(list)
      list.collect do |action|
        "<action name=\"#{action["name"]}\">
            <spark xmlns=\"uri:oozie:spark-action:0.1\">
              <job-tracker>${jobTracker}</job-tracker>
              <name-node>${nameNode}</name-node>
              <job-xml>#{self.name_node}/user/oozie/share/lib/spark/hive-site.xml</job-xml>
              <master>${master}</master>
              <mode>cluster</mode>
              <name>Secure-Log</name>
              <class>org.rhea.main.SparkCore</class>
              <jar>#{self.name_node}/user/saravanan/oozie_RHEA/lib/main-assembly-1.0.jar</jar>
              <spark-opts>${sparkOpts}</spark-opts>
                <arg>#{ spark_type(action["type"]) }</arg>
                <arg>#{action["id"]}</arg>
            </spark>
            <ok to=\"joinActions\"/>
            <error to=\"joinActions\"/>
        </action>"
      end.join("\n")
    end


    def get_workflow
      "<workflow-app xmlns=\"uri:oozie:workflow:0.4\" name=\"spark-wf\">
    <start to=\"spark-node\"/>
    <fork name=\"spark-node\">
        #{build_path(self.actions)}
    </fork>
    #{build_actions(self.actions)}
    <join name=\"joinActions\" to=\"summarization\"/>
    <kill name=\"fail\">
        <message>spark Failed, error message[${wf:errorMessage(wf:lastErrorNode())}]</message>
    </kill>
    <end name=\"end\"/>
    </workflow-app>"
    end

    def get_job_properties
      "nameNode=#{self.name_node}
    jobTracker=#{self.job_tracker}
    oozie.use.system.libpath=true
    queueName=default
    oozie.coord.application.path=${nameNode}/user/${user.name}/oozie_RHEA
    master=yarn-cluster
    queueName=default
    examplesRoot=examples
    spark_event_log_dir=hdfs:///logs/spark-history/${user.name}#Dynamic
    lib=${nameNode}/user/${user.name}/oozie_RHEA/lib
    oozielib=${nameNode}/user/oozie/share/lib/spark
    hivelib=${nameNode}/user/oozie/share/lib/hive
    sparkOpts=--verbose --driver-memory 5G --executor-memory 6G --executor-cores 3 --queue research --num-executors 30 --driver-library-path /opt/hadoop/lib/native/ --driver-java-options -XX:MaxPermSize=2024M --jars oozielib/hive-site.xml,oozielib/oozie-hive-site.xml,oozielib/hadoop-lzo-0.4.18-201604151956.jar,oozielib/snappy-java-1.1.2.jar,oozielib/datanucleus-api-jdo-3.2.6.jar,oozielib/datanucleus-core-3.2.10.jar,oozielib/datanucleus-rdbms-3.2.9.jar,oozielib/guava-14.0.1.jar --driver-class-path oozielib/oozie-hive-site.xml
    oozie.wf.application.path=${nameNode}/user/${user.name}/oozie_RHEA"
    end

    def get_all_coordinators

    end

    def get_coordinator_xml()
      "<coordinator-app name='#{self.pipeline_name}' start='#{self.schedule["start_time"]}' end='#{self.schedule["end_time"]}' frequency='#{self.schedule["frequency"]}'  timezone=\"UTC\" xmlns = \"uri:oozie:coordinator:0.4\">
            <action>
            <workflow>
                <app-path>${workflowAppUri}</app-path>
                <configuration>
                    <property>
                        <name>jobTracker</name>
                        <value>${jobTracker}</value>
                    </property>
                    <property>
                        <name>nameNode</name>
                        <value>${nameNode}</value>
                    </property>
                    <property>
                        <name>queueName</name>
                        <value>${queueName}</value>
                    </property>
                </configuration>
            </workflow>
        </action>
    </coordinator-app>"
    end


  end
end