class Project < ApplicationRecord
  has_and_belongs_to_many :accounts

  # has_many :images, dependent: :destroy

  has_many_attached :images

  has_many :keywords, dependent: :destroy
  accepts_nested_attributes_for :keywords, allow_destroy: true

  # def as_json(options = {})
  #   super(options.merge(jsonProjectsModel))
  # end
end
