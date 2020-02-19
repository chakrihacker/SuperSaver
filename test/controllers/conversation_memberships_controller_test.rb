require 'test_helper'

class ConversationMembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conversation_membership = conversation_memberships(:one)
  end

  test "should get index" do
    get conversation_memberships_url
    assert_response :success
  end

  test "should get new" do
    get new_conversation_membership_url
    assert_response :success
  end

  test "should create conversation_membership" do
    assert_difference('ConversationMembership.count') do
      post conversation_memberships_url, params: { conversation_membership: { conversation_id: @conversation_membership.conversation_id, user_id: @conversation_membership.user_id } }
    end

    assert_redirected_to conversation_membership_url(ConversationMembership.last)
  end

  test "should show conversation_membership" do
    get conversation_membership_url(@conversation_membership)
    assert_response :success
  end

  test "should get edit" do
    get edit_conversation_membership_url(@conversation_membership)
    assert_response :success
  end

  test "should update conversation_membership" do
    patch conversation_membership_url(@conversation_membership), params: { conversation_membership: { conversation_id: @conversation_membership.conversation_id, user_id: @conversation_membership.user_id } }
    assert_redirected_to conversation_membership_url(@conversation_membership)
  end

  test "should destroy conversation_membership" do
    assert_difference('ConversationMembership.count', -1) do
      delete conversation_membership_url(@conversation_membership)
    end

    assert_redirected_to conversation_memberships_url
  end
end
