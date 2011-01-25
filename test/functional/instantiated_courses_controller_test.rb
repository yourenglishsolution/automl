require 'test_helper'

class InstantiatedCoursesControllerTest < ActionController::TestCase
  setup do
    @instantiated_course = instantiated_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instantiated_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instantiated_course" do
    assert_difference('InstantiatedCourse.count') do
      post :create, :instantiated_course => @instantiated_course.attributes
    end

    assert_redirected_to instantiated_course_path(assigns(:instantiated_course))
  end

  test "should show instantiated_course" do
    get :show, :id => @instantiated_course.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @instantiated_course.to_param
    assert_response :success
  end

  test "should update instantiated_course" do
    put :update, :id => @instantiated_course.to_param, :instantiated_course => @instantiated_course.attributes
    assert_redirected_to instantiated_course_path(assigns(:instantiated_course))
  end

  test "should destroy instantiated_course" do
    assert_difference('InstantiatedCourse.count', -1) do
      delete :destroy, :id => @instantiated_course.to_param
    end

    assert_redirected_to instantiated_courses_path
  end
end
