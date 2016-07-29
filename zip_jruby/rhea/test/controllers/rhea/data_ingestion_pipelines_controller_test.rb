require 'test_helper'

module Rhea
  class DataIngestionPipelinesControllerTest < ActionController::TestCase
    setup do
      @data_ingestion_pipeline = rhea_data_ingestion_pipelines(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:data_ingestion_pipelines)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create data_ingestion_pipeline" do
      assert_difference('DataIngestionPipeline.count') do
        post :create, data_ingestion_pipeline: { connector_type: @data_ingestion_pipeline.connector_type, credentials: @data_ingestion_pipeline.credentials, name: @data_ingestion_pipeline.name, schedule: @data_ingestion_pipeline.schedule, sink_path: @data_ingestion_pipeline.sink_path, workflow_id: @data_ingestion_pipeline.workflow_id }
      end

      assert_redirected_to data_ingestion_pipeline_path(assigns(:data_ingestion_pipeline))
    end

    test "should show data_ingestion_pipeline" do
      get :show, id: @data_ingestion_pipeline
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @data_ingestion_pipeline
      assert_response :success
    end

    test "should update data_ingestion_pipeline" do
      patch :update, id: @data_ingestion_pipeline, data_ingestion_pipeline: { connector_type: @data_ingestion_pipeline.connector_type, credentials: @data_ingestion_pipeline.credentials, name: @data_ingestion_pipeline.name, schedule: @data_ingestion_pipeline.schedule, sink_path: @data_ingestion_pipeline.sink_path, workflow_id: @data_ingestion_pipeline.workflow_id }
      assert_redirected_to data_ingestion_pipeline_path(assigns(:data_ingestion_pipeline))
    end

    test "should destroy data_ingestion_pipeline" do
      assert_difference('DataIngestionPipeline.count', -1) do
        delete :destroy, id: @data_ingestion_pipeline
      end

      assert_redirected_to data_ingestion_pipelines_path
    end
  end
end
