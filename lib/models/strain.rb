class Strain < ActiveRecord::Base
has_many :userstrains
has_many :users, through: :userstrains 
end
