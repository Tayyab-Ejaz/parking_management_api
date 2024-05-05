require "test_helper"

class ParkingSlotControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parking_slot_index_url
    assert_response :success
  end
end
