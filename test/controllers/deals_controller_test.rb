require 'test_helper'

class DealsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deal = deals(:one)
  end

  test "should get index" do
    get deals_url
    assert_response :success
  end

  test "should get new" do
    get new_deal_url
    assert_response :success
  end

  test "should create deal" do
    assert_difference('Deal.count') do
      post deals_url, params: { deal: { cashback: @deal.cashback, category_id: @deal.category_id, deal_type: @deal.deal_type, description: @deal.description, end_date: @deal.end_date, is_local_deal: @deal.is_local_deal, latitude: @deal.latitude, longitude: @deal.longitude, min_price: @deal.min_price, name: @deal.name, status: @deal.status, user_id: @deal.user_id, vendor: @deal.vendor } }
    end

    assert_redirected_to deal_url(Deal.last)
  end

  test "should show deal" do
    get deal_url(@deal)
    assert_response :success
  end

  test "should get edit" do
    get edit_deal_url(@deal)
    assert_response :success
  end

  test "should update deal" do
    patch deal_url(@deal), params: { deal: { cashback: @deal.cashback, category_id: @deal.category_id, deal_type: @deal.deal_type, description: @deal.description, end_date: @deal.end_date, is_local_deal: @deal.is_local_deal, latitude: @deal.latitude, longitude: @deal.longitude, min_price: @deal.min_price, name: @deal.name, status: @deal.status, user_id: @deal.user_id, vendor: @deal.vendor } }
    assert_redirected_to deal_url(@deal)
  end

  test "should destroy deal" do
    assert_difference('Deal.count', -1) do
      delete deal_url(@deal)
    end

    assert_redirected_to deals_url
  end
end
