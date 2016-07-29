require_dependency "rhea/application_controller"

module Rhea
  class AggregationsController < ApplicationController
    before_action :set_aggregation, only: [:show, :edit, :update, :destroy]

    # GET /aggregations
    def index
      @aggregations = Aggregation.all
    end

    # GET /aggregations/1
    def show
    end

    # GET /aggregations/new
    def new
      @aggregation = Aggregation.new
    end

    # GET /aggregations/1/edit
    def edit
    end

    # POST /aggregations
    def create
      @aggregation = Aggregation.new(aggregation_params)

      if @aggregation.save
        redirect_to @aggregation, notice: 'Aggregation was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /aggregations/1
    def update
      if @aggregation.update(aggregation_params)
        redirect_to @aggregation, notice: 'Aggregation was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /aggregations/1
    def destroy
      @aggregation.destroy
      redirect_to aggregations_url, notice: 'Aggregation was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_aggregation
        @aggregation = Aggregation.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def aggregation_params
        params.require(:aggregation).permit!
      end
  end
end
