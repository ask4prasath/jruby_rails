module Rhea
  class Dataset < ActiveRecord::Base
    belongs_to :workflow

    def accumulations
      connectors = self.workflow.raw_data["connectors"].collect {|c| c["name"]} rescue []
      curations = self.workflow.raw_data["curations"].collect {|c| c["name"]} rescue []
      aggregations = self.workflow.raw_data["aggregations"].collect {|c| c["name"]} rescue []
      (connectors + curations + aggregations).flatten
    end

    def connectors
      connectors = self.workflow.raw_data["connectors"].collect {|c| c["name"]} rescue []
    end

    def curations
      curations = self.workflow.raw_data["curations"].collect {|c| c["name"]} rescue []
    end

  end
end
