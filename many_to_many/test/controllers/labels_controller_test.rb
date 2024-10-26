require "test_helper"

class LabelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @label = labels(:one)
  end

  test "should get index" do
    get labels_url, as: :json
    assert_response :success
  end

  test "should create label" do
    assert_difference("Label.count") do
      post labels_url, params: { label: { name: @label.name } }, as: :json
    end

    assert_response :created
  end

  test "should show label" do
    get label_url(@label), as: :json
    assert_response :success
  end

  test "should update label" do
    patch label_url(@label), params: { label: { name: @label.name } }, as: :json
    assert_response :success
  end

  test "should destroy label" do
    assert_difference("Label.count", -1) do
      delete label_url(@label), as: :json
    end

    assert_response :no_content
  end
end
