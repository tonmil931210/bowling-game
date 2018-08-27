require "application_system_test_case"

class FramesTest < ApplicationSystemTestCase
  setup do
    @frame = frames(:one)
  end

  test "visiting the index" do
    visit frames_url
    assert_selector "h1", text: "Frames"
  end

  test "creating a Frame" do
    visit frames_url
    click_on "New Frame"

    fill_in "Frame By User", with: @frame.frame_by_user_id
    fill_in "Score", with: @frame.score
    fill_in "Try1", with: @frame.try1
    fill_in "Try2", with: @frame.try2
    fill_in "Try3", with: @frame.try3
    fill_in "Turn", with: @frame.turn
    click_on "Create Frame"

    assert_text "Frame was successfully created"
    click_on "Back"
  end

  test "updating a Frame" do
    visit frames_url
    click_on "Edit", match: :first

    fill_in "Frame By User", with: @frame.frame_by_user_id
    fill_in "Score", with: @frame.score
    fill_in "Try1", with: @frame.try1
    fill_in "Try2", with: @frame.try2
    fill_in "Try3", with: @frame.try3
    fill_in "Turn", with: @frame.turn
    click_on "Update Frame"

    assert_text "Frame was successfully updated"
    click_on "Back"
  end

  test "destroying a Frame" do
    visit frames_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Frame was successfully destroyed"
  end
end
