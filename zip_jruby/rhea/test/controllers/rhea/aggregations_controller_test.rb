require 'test_helper'

module Rhea
  class AggregationsControllerTest < ActionController::TestCase
    setup do
      @aggregation = rhea_aggregations(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:aggregations)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create aggregation" do
      assert_difference('Aggregation.count') do
        post :create, aggregation: { aggregation_type: @aggregation.aggregation_type, correlation_ids: @aggregation.correlation_ids, file_path: @aggregation.file_path, name: @aggregation.name, query: @aggregation.query, schedule: @aggregation.schedule, status: @aggregation.status, workflow_id: @aggregation.workflow_id }
      end

      assert_redirected_to aggregation_path(assigns(:aggregation))
    end

    test "should show aggregation" do
      get :show, id: @aggregation
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @aggregation
      assert_response :success
    end

    test "should update aggregation" do
      patch :update, id: @aggregation, aggregation: { aggregation_type: @aggregation.aggregation_type, correlation_ids: @aggregation.correlation_ids, file_path: @aggregation.file_path, name: @aggregation.name, query: @aggregation.query, schedule: @aggregation.schedule, status: @aggregation.status, workflow_id: @aggregation.workflow_id }
      assert_redirected_to aggregation_path(assigns(:aggregation))
    end

    test "should destroy aggregation" do
      assert_difference('Aggregation.count', -1) do
        delete :destroy, id: @aggregation
      end

      assert_redirected_to aggregations_path
    end
  end
end
