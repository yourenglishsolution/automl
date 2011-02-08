require 'test_helper'

class InstantiatedProductsControllerTest < ActionController::TestCase
  setup do
    @instantiated_product = instantiated_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instantiated_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instantiated_product" do
    assert_difference('InstantiatedProduct.count') do
      post :create, :instantiated_product => @instantiated_product.attributes
    end

    assert_redirected_to instantiated_product_path(assigns(:instantiated_product))
  end

  test "should show instantiated_product" do
    get :show, :id => @instantiated_product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @instantiated_product.to_param
    assert_response :success
  end

  test "should update instantiated_product" do
    put :update, :id => @instantiated_product.to_param, :instantiated_product => @instantiated_product.attributes
    assert_redirected_to instantiated_product_path(assigns(:instantiated_product))
  end

  test "should destroy instantiated_product" do
    assert_difference('InstantiatedProduct.count', -1) do
      delete :destroy, :id => @instantiated_product.to_param
    end

    assert_redirected_to instantiated_products_path
  end
end
