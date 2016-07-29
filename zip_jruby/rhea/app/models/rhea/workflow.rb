module Rhea
  class Workflow < ActiveRecord::Base
    has_many :data_ingestions, class_name: Rhea::DataIngestionPipeline
    has_many :data_curations, class_name: Rhea::DataCurationPipeline

    before_update :increase_version

    def get_all_activities

    end

    def parse_name(raw_json)
      parsed_json = JSON.parse(raw_json) rescue nil
      parsed_json["connectors"].each_with_index  do |connector, index|
        running_status(connector, index, parsed_json["curations"])
      end rescue nil

      parsed_json["curations"].each_with_index  do |curations, index|
        running_status(curations, index, parsed_json["aggregations"])
      end rescue nil

      parsed_json["aggregations"].each_with_index  do |aggregations, index|
        running_status(aggregations, index, [])
      end rescue nil

      parsed_json || raw_json
    end

    def raw_data
      parse_name(read_attribute(:raw_data))
    end

    def running_status(connector, index, childrens)
      activity = Activity.where(activity_type: connector["name"], workflow_id: self.id).last
      if activity.present?
        activity.update_status(index, childrens, self) if activity.running?
        connector["lastStatus"] = activity.status
        connector["progress"] = activity.progress_percentage
        connector["operation"] = activity.status
        connector["time"] = activity.duration
        connector["status"] = activity.status
      end
    end

    def self.currently_running
      []
      #TODO
    end

    def self.recently_completed

    end

    def generate_oozie_files
      Rhea::OozieBuilder.generate_files(self)
    end

    def save_workflow_files
      generate_oozie_files.each do |oozie|
        oozie.save
      end
    end

    def submit
      Rhea::OozieBuilder.submit(self)
    end

    private

    def increase_version
      self.version = self.version.to_i + 1
    end

  end
end
