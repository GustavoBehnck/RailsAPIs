class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show update destroy ]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.new(project_params.except(:label_names))

    # Se passar o parâmetro label_names enves do label_ids, ele procurará por ele
    if project_params.key?(:label_names) and !project_params.key?(:label_ids)
      @project.labels = Label.where(name: project_params[:label_names])
    end

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    # Se passar o parâmetro label_names enves do label_ids, ele procurará por ele
    if project_params.key?(:label_names) and !project_params.key?(:label_ids)
      @project.labels = Label.where(name: project_params[:label_names])
    end

    if @project.update(project_params.except(:label_names))
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(
        :name,
        :body,
        label_ids: [],
        label_names: [],
        account_ids: [],
        participants: [ :name, :role ]
      )
    end
end
