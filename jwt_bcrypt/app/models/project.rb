class Project < ApplicationRecord
  belongs_to :account

  def as_json(options = {})
    super(options.merge(include: { account: { only: [ :name, :email ] } }))
  end
end
