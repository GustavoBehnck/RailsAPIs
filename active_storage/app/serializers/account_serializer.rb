class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone
  has_many :projects
end
