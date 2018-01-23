class User < ActiveRecord::Base
has_many :userstrains
has_many :strains, through: :userstrains
has_many :user_searches
has_many :searches, through: :user_searches

end
