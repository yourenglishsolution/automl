require 'test_helper'

class SubscribedCoursesControllerTest < ActionController::TestCase
  setup do
    @subscribed_course = subscribed_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscribed_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscribed_course" do
    assert_difference('SubscribedCourse.count') do
      post :create, :subscribed_course => @subscribed_course.attributes
    end

    assert_redirected_to subscribed_course_path(assigns(:subscribed_course))
  end

  test "should show subscribed_course" do
    get :show, :id => @subscribed_course.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @subscribed_course.to_param
    assert_response :success
  end

  test "should update subscribed_course" do
    put :update, :id => @subscribed_course.to_param, :subscribed_course => @subscribed_course.attributes
    assert_redirected_to subscribed_course_path(assigns(:subscribed_course))
  end

  test "should destroy subscribed_course" do
    assert_difference('SubscribedCourse.count', -1) do
      delete :destroy, :id => @subscribed_course.to_param
    end

    assert_redirected_to subscribed_courses_path
  end
end
