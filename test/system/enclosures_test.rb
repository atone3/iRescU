require "application_system_test_case"

class EnclosuresTest < ApplicationSystemTestCase
  setup do
    @enclosure = enclosures(:one)
  end

  test "visiting the index" do
    visit enclosures_url
    assert_selector "h1", text: "Enclosures"
  end

  test "creating a Enclosure" do
    visit enclosures_url
    click_on "New Enclosure"

    fill_in "Name", with: @enclosure.name
    click_on "Create Enclosure"

    assert_text "Enclosure was successfully created"
    click_on "Back"
  end

  test "updating a Enclosure" do
    visit enclosures_url
    click_on "Edit", match: :first

    fill_in "Name", with: @enclosure.name
    click_on "Update Enclosure"

    assert_text "Enclosure was successfully updated"
    click_on "Back"
  end

  test "destroying a Enclosure" do
    visit enclosures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Enclosure was successfully destroyed"
  end
end
