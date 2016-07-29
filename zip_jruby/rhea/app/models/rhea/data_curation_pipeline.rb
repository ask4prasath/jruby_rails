module Rhea
  class DataCurationPipeline < ActiveRecord::Base
    belongs_to :workflow
  end
end
