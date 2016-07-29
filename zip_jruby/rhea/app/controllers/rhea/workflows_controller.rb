require_dependency "rhea/application_controller"

module Rhea
  class WorkflowsController < ApplicationController
    before_action :set_workflow, only: [:show, :update, :destroy]

    # GET /workflows
    def index
      @workflows = Workflow.page(params[:page] || 0).per(params[:per] || 10).order("created_at desc")
      render json: {total_count: @workflows.total_count, records: @workflows}.to_json


    end

    # GET /workflows/1
    def show
      render json: @workflow.to_json
    end

    # POST /workflows
    def create
      @workflow = Workflow.where(name: params["workflow"]["name"]).first || Workflow.new(name: params["workflow"]["name"])
      @workflow.status = "Active"
      @workflow.version = 1
      @workflow.raw_data = params["workflow"].to_json
      @workflow.created_by = "Nicholas Nicholas"
      @workflow.save

      @dataset = Rhea::Dataset.new
      @dataset.name = @workflow.name
      @dataset.status = "Pending for Approval"
      @dataset.workflow_id = @workflow.id
      @dataset.save

      Activity.create(activity_id: @workflow.id, activity_type: @workflow.class.to_s, message: "Before Save", obj_attributes: @workflow.to_json, user_id: 24)  rescue nil
      render json: @workflow.to_json
    end

    # PATCH/PUT /workflows/1
    def update
      @workflow.update(workflow_params)
      @workflow.status = "Active" if params[:activate].present?
      @workflow.save

      @dataset = Dataset.where(workflow_id: @workflow.id).last
      @dataset.status = "Active"
      @dataset.save

      render json: @workflow.to_json
    end

    def run
      @workflow = Workflow.where(name: params[:workflow_name]).first
      @workflow.status = "Running"
      @workflow.save
      Activity.create(activity_type: params[:action_name], status: "Running", workflow_id: @workflow.id)
      render json: @workflow.to_json
    end

    def stop
      @workflow = Workflow.where(name: params[:workflow_name]).first
      activity = Activity.where(activity_type: params["activity_type"], workflow_id: @workflow.id).last
      activity.status = "0/4 Stopped"
      activity.save
      render json: {}
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_workflow
        @workflow = Workflow.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def workflow_params
        params.require("dataWorkflow").permit!
      end
  end
end
