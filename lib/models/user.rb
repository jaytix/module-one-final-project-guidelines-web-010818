class User < ActiveRecord::Base
has_many :user_strains
has_many :strains, through: :user_strains
has_many :user_searches
has_many :searches, through: :user_searches

# def add_to_favorites(self,strain)
#  UserStrain.create(user_id: user.id, strain_id: strain.id)
# end
end
