module Rhea
  class Aggregation < ActiveRecord::Base
    belongs_to :workflow
  end
end
