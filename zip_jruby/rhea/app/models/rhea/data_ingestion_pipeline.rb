module Rhea
  class DataIngestionPipeline < ActiveRecord::Base
    belongs_to :workflow
  end
end
