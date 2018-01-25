class CLI

  def welcome
    puts "Welcome to our app"
    puts "what is your name?"
    input = gets.chomp
    input
  end

  def create_new_user(input)
    @user = User.find_or_create_by(name: input)
  end

  def main_menu
    puts "1. Aliments"
    puts "2. Good Vibes"
    puts "3. Search"
    puts "4. Strain of the Day"
    puts "5. Exit"
    puts "Enter a number [1-5]"
    input = gets.chomp

    case input
    when "1"
      #aliments method
      more_info_method(first_ailemnt_method)
    when "2"
      more_info_method(first_positve_method)
    when "3"
      access_favorites_method
    when "4"
      #strain of the day method
      strain_of_the_day
      main_menu
    when "5"
      #exit APP
    when "password1"
      #admin function select user by user id to display user info
    when "password2"
      #admin function search by search history
    else
      puts "you have entered an incorrect key. please try again"
      main_menu
    end
  end


  def feelings
    a = ["Thats no fun", "Hate when happens", "hmm..rough week huh?"]
  end

  def list_of_ailments
    puts "1.Insomnia 2.Pain 3.Stress 4.Nausea"
    puts "5.Fatigue 6.Headache 7.Muscle Spasms"
    puts "8.Depression 9.Cramps 10.Inflammation"
    puts "Please enter the number that cooresponds with your discomfort."
    input = gets.chomp
    input
  end


  def retrieve_user_strains(array)
    array.each_with_index {|strain,indx| puts "#{indx+1}.#{strain.name}"}
    array
  end

  def find_strains_from_api_for_medical_purposes(user_search_input)
      array_of_choices = Strain.all.select do |strain|
        strain.medical.include?(user_search_input.capitalize)
      end
    userArr = array_of_choices.shuffle[0,5]
    userArr
  end

def ailments_arr
  ailments_array = ["Insomnia","Pain","Stress","Lack of Appetite","Nausea","Fatigue",
   "Headache","Muscle Spasms","Depression","Cramps","Inflammation","Eye Pressure"]
 end

  def first_ailemnt_method
    puts "What seems to be bothering you?"
    input = list_of_ailments
    input = input.to_i
    input -= 1
    user_strain_arr = []
    if input < 11
      ailments_arr.each_with_index do |ailment,ind|
        if input == ind
          puts "#{ailment}.. #{feelings.shuffle.first}."
          puts "Lets See What We Got for you. . ."
          ailment
          puts "These strains are our best recommendation for #{ailment}."
          find_strains_from_api_for_medical_purposes(ailment).each_with_index do |strain,ind|
             user_strain_arr << strain
             puts "#{ind+1}.#{strain.name}"
          end
        end
      end
    else
      puts "Make another selection"
      first_ailemnt_method
    end
    user_strain_arr
end

def more_info_method(array)
  houseArr = array
  puts "Select a strain for more information"
  puts "Enter key from 1-5"
  input = gets.chomp
  input = input.to_i
  input -= 1
  if input < 6
    array.each_with_index do |strain,ind|
      if input == ind
        new_strain_arr << strain
        puts "name: #{strain.name}"
        puts "race: #{strain.race}"
        puts "flavor: #{strain.flavors}"
        puts "positive effects: #{strain.positive_effects}"
          puts "Would you like to add this strain to your favorites?(y/n)"
          userin = gets.chomp.downcase
          if userin == "y"
            UserStrain.create(user_id: @user.id, strain_id: strain.id)
            puts "#{strain.name} has been added to your favorites!"
          end
        end
      end
  else
    "make a valid selection"
    more_info_method(houseArr)
  end

  puts "Would you like to.."
  puts "1. Learn about another strain of yours"
  puts "2. Go to Main Menu"
  userinput = gets.chomp.to_i
  if userinput == 1
    puts "#{@user.name}'s Strains'"
    houseArr.each_with_index do |strain,ind|
       puts "#{ind+1}.#{strain.name}"
     end
    more_info_method(houseArr)
  elsif userinput == 2
    main_menu
  end

end

#############################
############################ positive_effects
#######################

def positives_arr
  pos_array=["Relaxed","Euphoric","Happy","Energetic","Focused","Giggly",
    "Creative","Uplifted", "Sleepy", "Talkative","Hungry"]
end

def positive_feelings
  a = ["Yeaa, I dig that!", "I should join you.", "Thats a nice place to be."]
end

def list_of_positives
  puts "1.Relaxed 2.Euphoric 3.Happy 4.Energetic"
  puts "5.Focused 6.Giggly 7.Creative 8.Uplifted"
  puts "9.Sleepy 10.Talkative 11.Hungry"
  puts "Please enter the number that cooresponds with your discomfort."
  input = gets.chomp
  input
end

def retrieve_user_strains(array)
  array.each_with_index {|strain,indx| puts "#{indx+1}.#{strain.name}"}
  array
end

def find_strains_from_api_for_positive_purposes(user_search_input)
    array_of_choices = Strain.all.select do |strain|
      strain.positive_effects.include?(user_search_input.capitalize)
    end
  userArr = array_of_choices.shuffle[0,5]
  userArr
end


def first_positve_method
  puts "What Mood are you looking for today?"
  input = list_of_positives
  input = input.to_i
  input -= 1
  user_strain_arr = []
  if input < 12
    positives_arr.each_with_index do |poseffect,ind|
      if input == ind
        puts "#{poseffect}.. #{positive_feelings.shuffle.first}."
        puts "Lets See What We Got for you. . ."
        poseffect
        puts "So, If you want to be #{poseffect}, these are our recommendations."
        find_strains_from_api_for_positive_purposes(poseffect).each_with_index do |strain,indx|
           user_strain_arr << strain
           puts "#{indx+1}.#{strain.name}"
        end
      end
    end
  else
    puts "Make another selection"
    first_ailemnt_method
  end
  user_strain_arr
end


def more_info_method(array)
  houseArr = array
  puts "Select a strain for more information"
  puts "Enter key from 1-5"
  input = gets.chomp
  input = input.to_i
  input -= 1
  if input < 6
    array.each_with_index do |strain,ind|
      if input == ind
        binding.pry
        puts "name: #{strain.name}"
        puts "race: #{strain.race}"
        puts "flavor: #{strain.flavors}"
        puts "Helps alleviate discomfort from: #{strain.medical}"
          puts "Would you like to add this strain to your favorites?(y/n)"
          userin = gets.chomp.downcase
          if userin == "y"
            UserStrain.create(user_id: @user.id, strain_id: strain.id)
            puts "#{strain.name} has been added to your favorites!"
          end
        end
      end
  else
    "make a valid selection"
    more_info_method(houseArr)
  end

  puts "Would you like to.."
  puts "1. Learn more about Recommended Strain"
  puts "2. Go to Main Menu"
  userinput = gets.chomp.to_i
  if userinput == 1
    puts "#{@user.name}'s Strains'"
    houseArr.each_with_index do |strain,ind|
       puts "#{ind+1}.#{strain.name}"
     end
    more_info_method(houseArr)
  elsif userinput == 2
    main_menu
  end

end


#############################
############################ favorites
#######################


def access_favorites_method
  user_fave = UserStrain.all.select do |ustrain|
    ustrain.user_id == @user

  binding.pry
end
end
def recipes #ok
    myRecipes = RecipeCard.all.select do |rCard|
      rCard.user == self
    end
    myRecipes.map do |myrecipecard|
      myrecipecard.recipe
    end
  end















def run
input = welcome
user = create_new_user(input)
puts "Welcome #{user.name.titleize}"
 main_menu
end







  # def anything_else
  #   puts "is there anything else bothering you?(y/n)"
  #   input = gets.chomp
  #   if input.downcase == "y"
  #     another_ailment_method
  #   elsif choice.downcase == "n"
  #     puts "choose a strain to add to your favorites"
  #     favorites_method(first_ailemnt_method)
  #   else
  #     puts "I don't think we can help with that. Make another selection"
  #     anything_else
  #   end
  # end
  #
  # def another_ailment_method
  #   list_of_ailments
  #   ailments_Array.each_with_index do |ailment,ind|
  #     if choice.to_i == ind
  #       puts "#{ailment}"
  #       second_ailmentStrain_arr = user_ailmentStrain_array.select {|strain| strain.medical.include?(ailment)}
  #     else
  #       puts "I don't think we can help with that. Make another selection"
  #       another_ailment_method
  #     end
  #   end
  #   puts "We Recommend these strains for what ails you"
  #   retrieve_user_strains(second_ailmentStrain_arr) #return value is 2ndStrainArr
  # end
  #
  # def strain_of_the_day
  #   random_strain = Strain.all.sample
  #   puts random_strain.name
  #   puts random_strain.race
  # end

  # def favorites_method(strainArr)
  #   puts "You got some good stuff, would you like more info (y/n)"
  #   choice
  #   if choice.downcase == "y"
  #     puts "Which strain would you like to know more about?"
  #     puts "Please select the number that cooresponds"
  #     retrieve_user_strains(strainArr)
  #     choice
  #     strainArr.each_with_index do |strain,indx|
  #       if choice.to_i == indx+1
  #         puts "#{strain}"
  #       end
  #     end
  #   end
  # end



end
