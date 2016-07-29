require 'test_helper'

module Rhea
  class DataCurationPipelinesControllerTest < ActionController::TestCase
    setup do
      @data_curation_pipeline = rhea_data_curation_pipelines(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:data_curation_pipelines)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create data_curation_pipeline" do
      assert_difference('DataCurationPipeline.count') do
        post :create, data_curation_pipeline: { dataset_id: @data_curation_pipeline.dataset_id, file_attributes: @data_curation_pipeline.file_attributes, file_type: @data_curation_pipeline.file_type, hdfs_path: @data_curation_pipeline.hdfs_path, name: @data_curation_pipeline.name, parent: @data_curation_pipeline.parent, regex: @data_curation_pipeline.regex, schedule: @data_curation_pipeline.schedule, workflow_id: @data_curation_pipeline.workflow_id }
      end

      assert_redirected_to data_curation_pipeline_path(assigns(:data_curation_pipeline))
    end

    test "should show data_curation_pipeline" do
      get :show, id: @data_curation_pipeline
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @data_curation_pipeline
      assert_response :success
    end

    test "should update data_curation_pipeline" do
      patch :update, id: @data_curation_pipeline, data_curation_pipeline: { dataset_id: @data_curation_pipeline.dataset_id, file_attributes: @data_curation_pipeline.file_attributes, file_type: @data_curation_pipeline.file_type, hdfs_path: @data_curation_pipeline.hdfs_path, name: @data_curation_pipeline.name, parent: @data_curation_pipeline.parent, regex: @data_curation_pipeline.regex, schedule: @data_curation_pipeline.schedule, workflow_id: @data_curation_pipeline.workflow_id }
      assert_redirected_to data_curation_pipeline_path(assigns(:data_curation_pipeline))
    end

    test "should destroy data_curation_pipeline" do
      assert_difference('DataCurationPipeline.count', -1) do
        delete :destroy, id: @data_curation_pipeline
      end

      assert_redirected_to data_curation_pipelines_path
    end
  end
end
