require 'test_helper'

class TasksuitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tasksuite = tasksuites(:one)
  end

  test "should get index" do
    get tasksuites_url
    assert_response :success
  end

  test "should get new" do
    get new_tasksuite_url
    assert_response :success
  end

  test "should create tasksuite" do
    assert_difference('Tasksuite.count') do
      post tasksuites_url, params: { tasksuite: { suite_id: @tasksuite.suite_id, task_id: @tasksuite.task_id } }
    end

    assert_redirected_to tasksuite_url(Tasksuite.last)
  end

  test "should show tasksuite" do
    get tasksuite_url(@tasksuite)
    assert_response :success
  end

  test "should get edit" do
    get edit_tasksuite_url(@tasksuite)
    assert_response :success
  end

  test "should update tasksuite" do
    patch tasksuite_url(@tasksuite), params: { tasksuite: { suite_id: @tasksuite.suite_id, task_id: @tasksuite.task_id } }
    assert_redirected_to tasksuite_url(@tasksuite)
  end

  test "should destroy tasksuite" do
    assert_difference('Tasksuite.count', -1) do
      delete tasksuite_url(@tasksuite)
    end

    assert_redirected_to tasksuites_url
  end
end
