class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show update destroy ]
  # usando esse método "authorize_request" ele valida o JWT e declara a variável @current_account com a conta que está fazendo a requisição
  before_action :authorize_request, except: %i[ create index ]

  wrap_parameters :account, include: [ :name, :email, :password, :password_confirmation, :phone ]

  # GET /accounts
  def index
    @accounts = Account.all
    render_account @accounts
  end

  # GET /accounts/1
  def show
    if @account == @current_account
      render_account @account
    else
      render json: {
        errors: "Action not permitted, it is not permitted to show data that is not yours"
      }, status: :unprocessable_entity
    end
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    if @account.save
      # render json: @account, status: :created, location: @account
      render_account @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account == @current_account
      if @account.update(account_params)
        render_account @account
      else
        render json: @account.errors, status: :unprocessable_entity
      end
    else
      render json: {
        errors: "Action not permitted, it is not permitted to alter data that is not yours"
      }, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1 - ROTA DELETADA, NÃO SE DELETA USUÁRIO
  def destroy
    if @account.destroy!
      render json: {
        deleted: "Success",
        user: @account
      }, status: :accepted
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :email, :password, :password_confirmation, :phone)
    end

    def render_account(account_data)
      render json: account_data, except: [ :password_digest, :created_at ]
    end
end
