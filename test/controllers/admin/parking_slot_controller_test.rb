require "test_helper"

class Admin::ParkingSlotControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_parking_slot_index_url
    assert_response :success
  end
end
