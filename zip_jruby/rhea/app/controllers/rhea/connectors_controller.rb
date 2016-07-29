require_dependency "rhea/application_controller"

module Rhea
  class ConnectorsController < ApplicationController
    before_action :set_connector, only: [:show, :update]

    # GET /connectors
    def index
      @connectors = Connector.page(params[:page] || 0).per(params[:per] || 10)
      render json: {total_count: @connectors.total_count, records: @connectors}.to_json
    end

    # GET /connectors/1
    def show
      render json: @connector.to_json
    end

    # POST /connectors
    def create
      @connector = Connector.new(connector_params)
      @connector.save
      render json: @connector.to_json
    end

    # PATCH/PUT /connectors/1
    def update
      @connector.update(connector_params)
      render json: @connector.to_json
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_connector
        @connector = Connector.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def connector_params
        params.require(:connector).permit!
      end
  end
end
