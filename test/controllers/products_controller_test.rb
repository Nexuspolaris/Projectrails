require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user
    @product = products(:one)
    @update ={
      :titre        => 'Lorem Ipsum two',
      :description  => 'wibes are fun !',
      :image_url    => 'lorem.jpg',
      :price        => 19.95
    }
    @create ={
      :titre        => 'Lorem Ipsum three 4',
      :description  => 'wibes are fun !',
      :image_url    => 'lorem.jpg',
      :price        => 19.95
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => @create 
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, :id => @product.to_param, :product => @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
