class UserSearch < ActiveRecord::Base
  belongs_to :user
  belongs_to :search
end