require "application_system_test_case"

class TasksuitesTest < ApplicationSystemTestCase
  setup do
    @tasksuite = tasksuites(:one)
  end

  test "visiting the index" do
    visit tasksuites_url
    assert_selector "h1", text: "Tasksuites"
  end

  test "creating a Tasksuite" do
    visit tasksuites_url
    click_on "New Tasksuite"

    fill_in "Suite", with: @tasksuite.suite_id
    fill_in "Task", with: @tasksuite.task_id
    click_on "Create Tasksuite"

    assert_text "Tasksuite was successfully created"
    click_on "Back"
  end

  test "updating a Tasksuite" do
    visit tasksuites_url
    click_on "Edit", match: :first

    fill_in "Suite", with: @tasksuite.suite_id
    fill_in "Task", with: @tasksuite.task_id
    click_on "Update Tasksuite"

    assert_text "Tasksuite was successfully updated"
    click_on "Back"
  end

  test "destroying a Tasksuite" do
    visit tasksuites_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tasksuite was successfully destroyed"
  end
end
