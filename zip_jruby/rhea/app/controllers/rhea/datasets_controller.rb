require_dependency "rhea/application_controller"

module Rhea
  class DatasetsController < ApplicationController
    before_action :set_dataset, only: [:show, :update]

    # GET /datasets
    def index
      @datasets = Dataset.page(params[:page] || 0).per(params[:per] || 10)
      render json: {total_count: @datasets.total_count, records: @datasets}.to_json
    end

    # GET /datasets/1
    def show
      render json: @dataset.to_json({:methods => [:accumulations, :connectors, :curations ]})
    end

    # POST /datasets
    def create
      @dataset = Dataset.new(dataset_params)
      @dataset.save
      render json: @dataset.to_json
    end

    # PATCH/PUT /datasets/1
    def update
      @dataset.update(dataset_params)
      render json: @dataset.to_json
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_dataset
        @dataset = Dataset.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def dataset_params
        params.require(:dataset).permit!
      end
  end
end
