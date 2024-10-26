class Account < ApplicationRecord
  has_and_belongs_to_many :projects

  def as_json(options = {})
    super(options.merge(
      {
        include: {
          projects: {
            except: [ :created_at ],
            include: {
              labels: {
                except: [
                  :created_at,
                  :updated_at
                ]
              }
            }
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
