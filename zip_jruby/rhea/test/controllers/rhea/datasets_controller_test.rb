require 'test_helper'

module Rhea
  class DatasetsControllerTest < ActionController::TestCase
    setup do
      @dataset = rhea_datasets(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:datasets)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create dataset" do
      assert_difference('Dataset.count') do
        post :create, dataset: { created_by: @dataset.created_by, name: @dataset.name, schema_key: @dataset.schema_key, schema_value: @dataset.schema_value, status: @dataset.status, workflow_id: @dataset.workflow_id }
      end

      assert_redirected_to dataset_path(assigns(:dataset))
    end

    test "should show dataset" do
      get :show, id: @dataset
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @dataset
      assert_response :success
    end

    test "should update dataset" do
      patch :update, id: @dataset, dataset: { created_by: @dataset.created_by, name: @dataset.name, schema_key: @dataset.schema_key, schema_value: @dataset.schema_value, status: @dataset.status, workflow_id: @dataset.workflow_id }
      assert_redirected_to dataset_path(assigns(:dataset))
    end

    test "should destroy dataset" do
      assert_difference('Dataset.count', -1) do
        delete :destroy, id: @dataset
      end

      assert_redirected_to datasets_path
    end
  end
end
