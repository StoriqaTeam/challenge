require "application_system_test_case"

class SuitesTest < ApplicationSystemTestCase
  setup do
    @suite = suites(:one)
  end

  test "visiting the index" do
    visit suites_url
    assert_selector "h1", text: "Suites"
  end

  test "creating a Suite" do
    visit suites_url
    click_on "New Suite"

    fill_in "Description", with: @suite.description
    fill_in "Name", with: @suite.name
    click_on "Create Suite"

    assert_text "Suite was successfully created"
    click_on "Back"
  end

  test "updating a Suite" do
    visit suites_url
    click_on "Edit", match: :first

    fill_in "Description", with: @suite.description
    fill_in "Name", with: @suite.name
    click_on "Update Suite"

    assert_text "Suite was successfully updated"
    click_on "Back"
  end

  test "destroying a Suite" do
    visit suites_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Suite was successfully destroyed"
  end
end
