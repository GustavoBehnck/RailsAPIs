class Account < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }

  has_and_belongs_to_many :projects

  # def as_json(options = {})
  #   super(options.merge(
  #     {
  #       include: {
  #         projects: jsonProjectsModel
  #       },
  #       except: [
  #         :created_at,
  #         :updated_at,
  #         :password_digest,
  #         :admin,
  #         :blocked
  #       ]
  #     }
  #   ))
  # end
end
