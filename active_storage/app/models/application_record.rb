class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def jsonProjectsModel
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
          },
          keywords: {
            except: [
              :created_at,
              :updated_at,
              :id,
              :project_id
            ]
          }
        },
        except: [
          :created_at
        ]
    }
  end
end
