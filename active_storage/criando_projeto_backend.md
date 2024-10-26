# Passos da criação do projeto

- [Passos da criação do projeto](#passos-da-criação-do-projeto)
  - [Criando Tabelas](#criando-tabelas)
    - [Accounts](#accounts)
    - [Projects](#projects)
    - [projects\_accounts](#projects_accounts)
    - [Keywords](#keywords)
  - [Modificando Tabelas (migrations)](#modificando-tabelas-migrations)
  - [Bcrypt](#bcrypt)
  - [JWT](#jwt)


## Criando Tabelas

### Accounts
***
```sh
rails generate scaffold Accounts name:text email:text password_digest:string phone:text blocked:boolean
```

Adicione o seguinte trecho ao model do `Accounts`:

```rb
class Account < ApplicationRecord
  has_and_belongs_to_many :projects


  # OPCIONAL
  def as_json(options = {})
    super(options.merge(
      {
        include: {
          projects: {
            except: [ :created_at ]
          }
        },
        except: [
          :created_at,
          :updated_at
        ]
      }
    ))
  end
end
```

Modifique primeiramente no `accounts_controller.rb` os atributos permitidos para serem inseridos para os seguintes:

```rb
params.require(:account).permit(
  :name,
  :email,
  :password_digest,
  :phone,
  :blocked,
  project_ids: []
)
```

### Projects
***
```sh
rails generate scaffold Projects title:text date_created:date body:text status:integer article:string blocked:boolean admin:boolean participants:json
```

Adicione o seguinte trecho ao model do `Projects`:

```rb
class Project < ApplicationRecord
  has_and_belongs_to_many :accounts


  # OPCIONAL
  def as_json(options = {})
    super(options.merge(
      {
        include: {
          accounts: {
            except: [
              :created_at,
              :updated_at,
              :admin,
              :blocked,
              :password_digest
            ]
          }
        },
        except: [ :created_at ]
      }
    ))
  end
end
```

Modifique primeiramente no `projects_controller.rb` os atributos permitidos para serem inseridos para os seguintes:

```rb
params.require(:project).permit(
  :title,
  :date_created,
  :body,
  :status,
  :article,
  :blocked,
  account_ids: [],
  participants: [ :name, :role ]
)
```

### projects_accounts
***
```sh
rails generate migration CreateAccountsProjectsJoinTable
```

Denstro da migração criada insira o seguinte trecho

```ruby
def change
    create_join_table :accounts, :projects
end
```

### Keywords
***

```sh
rails generate scaffold keywords description:text project:references
```

Adicione o seguinte trecho ao model do `Projects`:

```rb
has_many :keywords, dependent: :destroy
accepts_nested_attributes_for :keywords, allow_destroy: true
```

Modifique o `route.rb` com o seguinte:

```rb
resources :projects do
  resources :keywords, only: [ :index ]
end
```

Modifique o `keywords_controller.rb` com o seguinte:

```rb
class KeywordsController < ApplicationController
  before_action :set_keyword, only: %i[ show update destroy index ]

  def index
    render json: @keyword
  end

  private
    def set_keyword
      project = Project.find(params[:project_id])
      @keyword = project.keywords
    end

    def keyword_params
      params.require(:keyword).permit(:description)
    end
end
```

E modifique no `projects_controller.rb` o seguinte:

```rb
  def update
    @project.keywords.destroy_all
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end
  private
    def project_params
      params.require(:project).permit(keywords_attributes: [ :description ])
    end
```

## Modificando Tabelas (migrations)

É interessante colocar alguns atributos de algumas tableas como `not null` ou com um valor por padrão (`default`) ou `unique`.

Essas alterações devem ser feitas através de uma migração, porém podem ser feitas todas ao mesmo tempo, como será feito em algum dos exemplos a seguir

Crie a migração:

```sh
rails generate migration ChnageColumnsConfigAccounts
```

E coloque o seguinte na migração:

```rb
def change
  change_column :accounts, :blocked, :boolean, null: false, default: false
  change_column :accounts, :admin, :boolean, null: false, default: false
  add_index :accounts, :email, unique: true
end
```

## Bcrypt

primeiramente coloque o seu `Gemfile` a gem do JWT:

```rb
# Use ActiveModel has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt"
```

Adicione no model de `accounts` as seguintes coisas:

```rb
has_secure_password
validates :email, presence: true, uniqueness: true
validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
validates :password, length: { minimum: 8 }
```

Adicione no `accounts_controller.rb` as seguintes permissões:

```rb
def account_params
  params.require(:account).permit(:password,:password_confirmation)
end
```

## JWT

primeiramente coloque o seu `Gemfile` a gem do JWT:

```rb
# Use Json Web Token (JWT) for token based authentication
gem "jwt"
```

Crie o arquivo `./app/lib/JsonWebToken.rb`, dentro dele iremos inserir os comandos de codificar e decodificar como a seguir:

```rb
class JsonWebToken
  @rsa_private ||= OpenSSL::PKey::RSA.generate 1024
  @rsa_public = @rsa_private.public_key

  def self.encode(payload, exp = 1.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode payload, @rsa_private, "RS256"
  end

  def self.decode(token)
    decoded = JWT.decode token, @rsa_public, true, { algorithm: "RS256" }
    HashWithIndifferentAccess.new(decoded[0])
  end
end

```


Adicione no arquivo `routes.rb` a rota de autenticação:

```rb
post "/auth/login", to: "authentication#login"
get "/auth/decode", to: "authentication#decode" # Temporário, apenas para testes
```

Use o comando para criar o `controller` do authentication:

```sh
rails generate controller authentication
```

Insirá o método `login` e `decode` como abaixo:

```rb
class AuthenticationController < ApplicationController
  # POST /auth/login
  def login
    begin
      account = Account.find_by(email: params[:email])
      if account&.authenticate(params[:password])
        token = JsonWebToken.encode({
          account_id: account.id,
          account_name: account.name,
          admin: account.admin
        })
        render json: {
          token: token,
          exp: (Time.now + 1.hours.to_i).strftime("%m-%d-%Y %H:%M"),
          username: account.name
        }, status: :ok
      else
        render json: {
          errors: "Invalid username or password"
        }, status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::EncodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end


  # POST /auth/decode
  def decode
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = JsonWebToken.decode(header)
      render json: {
        decodado: @decoded
      }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end

```

Adicione no arquivo `application_controller.rb` o seguinte método:

```rb
def authorize_request
  header = request.headers["Authorization"]
  header = header.split(" ").last if header
  begin
    @decoded = JsonWebToken.decode(header)
    @current_account = Account.find(@decoded["account_id"])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end
end
```     

Com essa função é possível retornar o usuário que está utilizando esse token
