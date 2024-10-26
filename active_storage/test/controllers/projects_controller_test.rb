require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get projects_url, as: :json
    assert_response :success
  end

  test "should create project" do
    assert_difference("Project.count") do
      post projects_url, params: { project: { blocked: @project.blocked, body: @project.body, date_created: @project.date_created, participants: @project.participants, status: @project.status, title: @project.title } }, as: :json
    end

    assert_response :created
  end

  test "should show project" do
    get project_url(@project), as: :json
    assert_response :success
  end

  test "should update project" do
    patch project_url(@project), params: { project: { blocked: @project.blocked, body: @project.body, date_created: @project.date_created, participants: @project.participants, status: @project.status, title: @project.title } }, as: :json
    assert_response :success
  end

  test "should destroy project" do
    assert_difference("Project.count", -1) do
      delete project_url(@project), as: :json
    end

    assert_response :no_content
  end
end
