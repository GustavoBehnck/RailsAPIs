class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show update destroy ]
  # usando esse método "authorize_request" ele valida o JWT e declara a variável @current_account com a conta que está fazendo a requisição
  before_action :authorize_request, except: %i[ index ]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects
  end

  # GET /projects/1
  def show
    if @project.account == @current_account
      render_project @project
    else
      render json: {
        errors: "Action not permitted, it is not permitted to show data that is not yours"
      }, status: :unprocessable_entity
    end
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    @project.account = @current_account
    if @project.save
      render_project @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.account == @current_account
      if @project.update(project_params)
        render_project @project
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    else
      render json: {
        errors: "Action not permitted, it is not permitted to alter data that is not yours"
      }, status: :unprocessable_entity
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
      params.require(:project).permit(:name, :date_proj_started, :txt_body, :status, :file_path, :keywords, participants: [ :name, :role ])
    end

    def render_project(project_data)
      render json: project_data, except: [ :created_at, :account_id ], status: :ok
    end
end
