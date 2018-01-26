class Strain < ActiveRecord::Base
has_many :user_strains
has_many :users, through: :user_strains 
end
