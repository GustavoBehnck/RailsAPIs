class KeywordsController < ApplicationController
  before_action :set_keyword, only: %i[ show update destroy index ]

  # Get /projects/:project_id/keywords
  def index
    render json: @keyword
  end

  def show # NÃO ESTÁ SENDO USADO
    render json: Keyword.find(params[:id])
  end

  def create # NÃO ESTÁ SENDO USADO
    project = Project.find(params[:user_id])

    @keyword = project.keywords.build(keyword_params)

    if @keyword.save
      render json: @keyword, status: :created, location: @keyword
    else
      render json: @keyword.errors, status: :unprocessable_entity
    end
  end

  def update # NÃO ESTÁ SENDO USADO
    if @keyword.update(keyword_params)
      render json: @keyword
    else
      render json: @keyword.errors, status: :unprocessable_entity
    end
  end

  def destroy # NÃO ESTÁ SENDO USADO
    @keyword.destroy!
  end

  def search # NÃO ESTÁ SENDO USADO
    render json: {
      response: "UTILIZADO NO FUTURO"
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      project = Project.find(params[:project_id])
      @keyword = project.keywords
    end

    # Only allow a list of trusted parameters through.
    def keyword_params
      params.require(:keyword).permit(:description)
    end
end
