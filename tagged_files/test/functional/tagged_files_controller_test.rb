require 'test_helper'

class TaggedFilesControllerTest < ActionController::TestCase
  setup do
    @tagged_file = tagged_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tagged_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tagged_file" do
    assert_difference('TaggedFile.count') do
      post :create, tagged_file: @tagged_file.attributes
    end

    assert_redirected_to tagged_file_path(assigns(:tagged_file))
  end

  test "should show tagged_file" do
    get :show, id: @tagged_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tagged_file
    assert_response :success
  end

  test "should update tagged_file" do
    put :update, id: @tagged_file, tagged_file: @tagged_file.attributes
    assert_redirected_to tagged_file_path(assigns(:tagged_file))
  end

  test "should destroy tagged_file" do
    assert_difference('TaggedFile.count', -1) do
      delete :destroy, id: @tagged_file
    end

    assert_redirected_to tagged_files_path
  end
end
