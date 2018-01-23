require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'



cannabis_data = RestClient.get('http://strainapi.evanbusse.com/rbLiiPJ/strains/search/all')
cannabis_JSON = JSON.parse(cannabis_data)


cannabis_JSON.each do |strain|
  Strain.create(name: strain[0], race: strain[1]["race"], medical:strain[1]["effects"]["medical"].join(", "),
    positive_effects:strain[1]["effects"]["positive"].join(", "), flavors:strain[1]["flavors"].join(", "))
  end

def create_users
  trav = User.create(name:"travis")
  josh = User.create(name: "josh")
  john = User.create(name: "john")
  jaime = User.create(name: "jamie")
  michelle = User.create(name: "michelle")
  jasmine = User.create(name: "jasmine")
  tory = User.create(name:"tory")
  declan = User.create(name: "declan")
  christy = User.create(name: "christy")
  anna = User.create(name: "anna")
  fara = User.create(name: "fara")
  osama = User.create(name:"osama")
  fei = User.create(name: "fei")
  alex = User.create(name: "alex")
  morgan = User.create(name: "morganne")
  vic = User.create(name: "vic")
  terrance = User.create(name: "terrance")
  kristina = User.create(name: "kristina")
  alexander = User.create(name: "alexander")
  joshua = User.create(name: "joshua")
  esmry = User.create(name: "esmery")
  gary = User.create(name: "gary")
  tashawn = User.create(name: "tashawn")
  hahn = User.create(name: "hahn")
  nem = User.create(name: "nem")
  julian = User.create(name: "julian")
  drew = User.create(name: "drew")
  matt = User.create(name: "matt")
  alexis = User.create(name: "alexis")
  alicia = User.create(name: "alicia")
  amanda = User.create(name: "amanda")
  eric = User.create(name: "eric")
  ariel = User.create(name: "ariel")

end
