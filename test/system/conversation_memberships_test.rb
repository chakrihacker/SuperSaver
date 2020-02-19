require "application_system_test_case"

class ConversationMembershipsTest < ApplicationSystemTestCase
  setup do
    @conversation_membership = conversation_memberships(:one)
  end

  test "visiting the index" do
    visit conversation_memberships_url
    assert_selector "h1", text: "Conversation Memberships"
  end

  test "creating a Conversation membership" do
    visit conversation_memberships_url
    click_on "New Conversation Membership"

    fill_in "Conversation", with: @conversation_membership.conversation_id
    fill_in "User", with: @conversation_membership.user_id
    click_on "Create Conversation membership"

    assert_text "Conversation membership was successfully created"
    click_on "Back"
  end

  test "updating a Conversation membership" do
    visit conversation_memberships_url
    click_on "Edit", match: :first

    fill_in "Conversation", with: @conversation_membership.conversation_id
    fill_in "User", with: @conversation_membership.user_id
    click_on "Update Conversation membership"

    assert_text "Conversation membership was successfully updated"
    click_on "Back"
  end

  test "destroying a Conversation membership" do
    visit conversation_memberships_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Conversation membership was successfully destroyed"
  end
end
