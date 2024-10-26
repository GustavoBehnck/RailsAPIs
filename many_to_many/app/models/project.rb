class Project < ApplicationRecord
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :accounts

  def as_json(options = {})
    super(options.merge(
      {
        include: {
          labels: {
            except: [
              :created_at,
              :updated_at
            ]
          },
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
