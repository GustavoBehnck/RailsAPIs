class Account < ApplicationRecord
  has_secure_password
  has_many :projects
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }

  def as_json(options = {})
    super(options.merge(include: { projects: { only: [ :id, :name, :date_proj_started ] } }))
  end
end
