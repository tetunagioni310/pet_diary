require 'test_helper'

class Public::SchedulesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get public_schedules_new_url
    assert_response :success
  end

  test 'should get show' do
    get public_schedules_show_url
    assert_response :success
  end

  test 'should get index' do
    get public_schedules_index_url
    assert_response :success
  end
end
