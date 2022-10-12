require "application_system_test_case"

class CourseMembershipsTest < ApplicationSystemTestCase
  setup do
    @course_membership = course_memberships(:one)
  end

  test "visiting the index" do
    visit course_memberships_url
    assert_selector "h1", text: "Course memberships"
  end

  test "should create course membership" do
    visit course_memberships_url
    click_on "New course membership"

    click_on "Create Course membership"

    assert_text "Course membership was successfully created"
    click_on "Back"
  end

  test "should update Course membership" do
    visit course_membership_url(@course_membership)
    click_on "Edit this course membership", match: :first

    click_on "Update Course membership"

    assert_text "Course membership was successfully updated"
    click_on "Back"
  end

  test "should destroy Course membership" do
    visit course_membership_url(@course_membership)
    click_on "Destroy this course membership", match: :first

    assert_text "Course membership was successfully destroyed"
  end
end
