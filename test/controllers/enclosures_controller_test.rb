require 'test_helper'

class EnclosuresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @enclosure = enclosures(:one)
  end

  test "should get index" do
    get enclosures_url
    assert_response :success
  end

  test "should get new" do
    get new_enclosure_url
    assert_response :success
  end

  test "should create enclosure" do
    assert_difference('Enclosure.count') do
      post enclosures_url, params: { enclosure: { name: @enclosure.name } }
    end

    assert_redirected_to enclosure_url(Enclosure.last)
  end

  test "should show enclosure" do
    get enclosure_url(@enclosure)
    assert_response :success
  end

  test "should get edit" do
    get edit_enclosure_url(@enclosure)
    assert_response :success
  end

  test "should update enclosure" do
    patch enclosure_url(@enclosure), params: { enclosure: { name: @enclosure.name } }
    assert_redirected_to enclosure_url(@enclosure)
  end

  test "should destroy enclosure" do
    assert_difference('Enclosure.count', -1) do
      delete enclosure_url(@enclosure)
    end

    assert_redirected_to enclosures_url
  end
end
