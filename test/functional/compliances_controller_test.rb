require 'test_helper'

class CompliancesControllerTest < ActionController::TestCase
  setup do
    @compliance = compliances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:compliances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create compliance" do
    assert_difference('Compliance.count') do
      post :create, :compliance => @compliance.attributes
    end

    assert_redirected_to compliance_path(assigns(:compliance))
  end

  test "should show compliance" do
    get :show, :id => @compliance.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @compliance.to_param
    assert_response :success
  end

  test "should update compliance" do
    put :update, :id => @compliance.to_param, :compliance => @compliance.attributes
    assert_redirected_to compliance_path(assigns(:compliance))
  end

  test "should destroy compliance" do
    assert_difference('Compliance.count', -1) do
      delete :destroy, :id => @compliance.to_param
    end

    assert_redirected_to compliances_path
  end
end
