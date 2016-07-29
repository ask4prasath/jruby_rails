require 'test_helper'

module Rhea
  class ConnectorsControllerTest < ActionController::TestCase
    setup do
      @connector = rhea_connectors(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:connectors)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create connector" do
      assert_difference('Connector.count') do
        post :create, connector: { created_by: @connector.created_by, status: @connector.status, title: @connector.title }
      end

      assert_redirected_to connector_path(assigns(:connector))
    end

    test "should show connector" do
      get :show, id: @connector
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @connector
      assert_response :success
    end

    test "should update connector" do
      patch :update, id: @connector, connector: { created_by: @connector.created_by, status: @connector.status, title: @connector.title }
      assert_redirected_to connector_path(assigns(:connector))
    end

    test "should destroy connector" do
      assert_difference('Connector.count', -1) do
        delete :destroy, id: @connector
      end

      assert_redirected_to connectors_path
    end
  end
end
