require_dependency "rhea/application_controller"

module Rhea
  class DashboardController < ApplicationController

    def index
      redis = Redis.new(:host => "ec2-52-90-69-133.compute-1.amazonaws.com", :port => 6379)
      valid_events = redis.get("validevents").split(",")
      invalid_events = redis.get("invalidevents").split(",")

      active_pipelines = Activity.limit(5).order("created_at desc").where.not(status: "4/4 Completed")
      recent_pipelines = Activity.limit(5).order("created_at desc").where(status: "4/4 Completed")

      render json: {real_time: {valid_events: valid_events, invalid_events: invalid_events},
                    metrics: {"Current Pipeline" => fixed_length(Rhea::Workflow.currently_running.size), "Total Pipeline" => fixed_length(Rhea::Workflow.count * 2), "Valid Events" => "15.3B", "Invalid Events" => "6.5M",
                              "active_pipeline" => {"count" =>  active_pipelines.count,
                                                    "pipelines" => active_pipelines},
                              "recently_completed" => {"count"  => recent_pipelines.count,
                                                       "pipelines" => recent_pipelines}
      }}.to_json
    end

    private

    def fixed_length(int)
      int.to_s.length == 1 ? "0" + int.floor.to_s : int.floor.to_s
    end

  end
end
