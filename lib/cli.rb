class CLI
  def welcome
    puts "Welcome to our app"
  end

  def user_password(pin)
    tru = true
    pinword = gets.chomp
     if !(User.find_by(user_id: pin, password: pinword))
       tru = false
     end
     tru
   end

  def sign_in_or_sign_up
    puts "Welcome to our app"
    puts "Do you have a User Pin?"
    puts "1. Yes, I have a pin"
    puts "2. No. I do not have a pin"
    userpin = gets.chomp.to_i
    if userpin == 1
      puts "enter pin"
      pin = gets.chomp.to_i
      binding.pry
      if !(User.find(pin))
        puts "Incorrect Pin."
        puts "Please try again"
        sign_in_or_sign_up
      elsif User.find_by(id: pin, password: nil)
        puts "New rules: All acconuts must have a password"
        puts "Enter New Password below"
        pword = gets.chomp
        User.find(pin).password = pword
        @user = User.find_by(id: pin, password: pword)
        puts "Please Sign in again"
        sign_in_or_sign_up
      elsif user_password(pin) == false
        puts " Incorrect password. Please try again."
        sign_in_or_sign_up
      elsif
        user_password(pin) == true
        puts "Please re-enter password"
        pword = gets.chomp
        User.find_by(id: pin, password: pword)
        @user = User.find_by(id: pin, password: pword)
        puts "Welcome back #{@user.name}"
        main_menu
      end

    elsif userpin == 2
      puts "You must create an account before using our services"
      puts "You'll get your pin shortly."
      sleep(1.4)
      puts "Lets first start with your name and password"
      sleep(1)
      puts "Enter is your name"
      username = gets.chomp
      puts "Almost done.. Now enter your password"
      pword = gets.chomp
      @user = User.create(name: username, password: pword )
      puts "Hey #{@user.name}"
      puts "Your pin is #{@user.id}"
      puts "Now you're Valid. Get started at the Main Menu"
      sleep(1)
      main_menu
    else
      puts "make a valid selection"
      sign_in_or_sign_up
    end

  end

  def main_menu
    puts "Welecome to the Main Menu!"
    puts "Make a selection"
    puts "1. Aliments"
    puts "2. Good Vibes"
    puts "3. Search for Users"
    puts "4. Strain of the Day"
    puts "5. Favorites"
    puts "6. Exit"
    puts "Enter a number [1-5]"
    input = gets.chomp

    case input
    when "1"
      #aliments method
      more_medical_info_method(first_ailemnt_method)
    when "2"
      more_positive_info_method(first_positve_method)
    when "3"
      next_method(access_users_of_strains)
    when "4"
      #strain of the day method
      strain_of_the_day
      main_menu
    when "5"
      view_favorite_strains
    when "6"
      exit
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

  def ailments_arr
    ailments_array = ["Insomnia","Pain","Stress","Nausea","Fatigue",
     "Headache","Muscle Spasms","Depression","Cramps","Inflammation"]
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

def more_medical_info_method(array)
  houseArr = array
  # houseArr2 = array
  puts "Select a strain for more information"
  puts "Enter key from 1-5"
  input = gets.chomp
  input = input.to_i
  input -= 1
  if input < 6
    array.each_with_index do |strain,ind|
      if input == ind
        puts "name: #{strain.name}"
        puts "race: #{strain.race.capitalize}"
        puts "flavors: #{strain.flavors}"
        puts "positive effects: #{strain.positive_effects}"
          puts "Would you like to add this strain to your favorites?(y/n)"
          userin = gets.chomp.downcase
          if userin == "y"
            current_US = UserStrain.find_by(user_id: @user.id)
              if  current_US == nil
                  UserStrain.create(user_id: @user.id, strain_id: strain.id)
                  puts "#{strain.name} has been added to you favorites"
              elsif !(current_US.user.strains.include? (strain))
                    UserStrain.create(user_id: @user.id, strain_id: strain.id)
                    puts "#{strain.name} has been added to your favorites"
              elsif current_US.user.strains.include? (strain)
                puts "#{strain.name} is already in your favorites"
              end

          elsif userin == "n"
            puts "Ok.. moving along.."

          end

        end
      end

  end

  puts "Would you like to.."
  puts "1. Learn about another strain of yours"
  puts "2. Go to Main Menu"
  userinput = gets.chomp.to_i
  if userinput == 1
    puts "#{@user.name.capitalize}'s Strains'"
    houseArr.each_with_index do |strain,ind|
       puts "#{ind+1}.#{strain.name}"
     end
    more_medical_info_method(houseArr)
  elsif userinput == 2
    main_menu
  end

end



#######################################################################################
############################ positive_effects#############################
#################################################################################

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
  puts "Please enter the number that cooresponds with desired Vibe."
  input = gets.chomp
  input
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


def more_positive_info_method(array)
  houseArr = array
  puts "Select a strain for more information"
  puts "Enter key from 1-5"
  input = gets.chomp
  input = input.to_i
  input -= 1
  if input < 6
    array.each_with_index do |strain,ind|
      if input == ind
        puts "name: #{strain.name}"
        puts "race: #{strain.race.capitalize}"
        puts "flavors: #{strain.flavors}"
        puts "may alleviate discomfort from: #{strain.medical.gsub(/ Lack of Appetite,/,"")}"
          puts "Would you like to add this strain to your favorites?(y/n)"
          userin = gets.chomp.downcase
          if userin == "y"
            current_US = UserStrain.find_by(user_id: @user.id)
            if current_US == nil
              UserStrain.create(user_id: @user.id, strain_id: strain.id)
              puts "#{strain.name} has been added to your favorites"
            elsif !(current_US.user.strains.include? (strain))
                UserStrain.create(user_id: @user.id, strain_id: strain.id)
                puts "#{strain.name} has been added to your favorites"
            elsif current_US.user.strains.include? (strain)
                puts "#{strain.name} is already in your favorites"
              end

          elsif userin == "n"
            puts "Ok.. moving along .."

          end
       end
     end

   end

  puts "Would you like to.."
  puts "1. Learn more about a Recommended Strain"
  puts "2. Go to Main Menu"
  userinput = gets.chomp.to_i
  if userinput == 1
    puts "#{@user.name}'s Strains'"
    houseArr.each_with_index do |strain,ind|
       puts "#{ind+1}.#{strain.name}"
     end
    more_positive_info_method(houseArr)
  elsif userinput == 2
    main_menu
  else
    main_menu
  end

end


##################################################################
############################ favorites########################################
###############################################################



def access_users_of_strains
  puts "Enter a Strain to see its Users"
  userinput = nil
  userinput = gets.chomp.titleize
    if Strain.all.find_by(name: userinput) != nil
      popStrain = Strain.all.find_by(name: userinput)
    else
      puts "That strain does not exist. Choose another"
      access_users_of_strains
    end
  puts "Most popular Users of #{userinput}."
  popStrain.users.each_with_index {|user,ind| puts "#{ind+1}. #{user.name}"}
  binding.pry

  popStrain
end

def next_method(strain)
  houseStrain = strain
  puts "What would you like to do next?"
  puts "1. Learn more info about #{strain.name}?"
  puts "2. Search for Users of another Strain"
  puts "3. Add Strain to Favorites"
  puts "4. Return to Main Menu"
  input = gets.chomp.to_i
    if input == 1
      puts "name: #{strain.name}"
      puts "race: #{strain.race.capitalize}"
      puts "flavors: #{strain.flavors}"
      puts "positive_effects: #{strain.positive_effects}"
      puts "may alleviate discomfort from: #{strain.medical.gsub(/ Lack of Appetite,/,"")}"
      next_method(houseStrain)
    elsif input == 2
      next_method(access_users_of_strains)
    elsif input == 3
      current_US = UserStrain.find_by(user_id: @user.id)
      if current_US == nil
        UserStrain.create(user_id: @user.id, strain_id: strain.id)
        puts "#{strain.name} has been added to your favorites"
      elsif !(current_US.user.strains.include? (strain))
          UserStrain.create(user_id: @user.id, strain_id: strain.id)
          puts "#{strain.name} has been added to your favorites"
      elsif current_US.user.strains.include? (strain)
          puts "#{strain.name} is already in your favorites"
        end
        next_method(houseStrain)
    elsif input == 4
      main_menu
    else
      puts "make another selection"
      next_method(houseStrain)
    end
  end

  def view_favorite_strains
    current_US = UserStrain.find_by(user_id: @user.id)
    if current_US == nil
      puts "You have no favorite strains"
      sleep(1)
      main_menu
    else
      puts "These are your favorite strains"
      ustrain = current_US.user.strains.each_with_index {|us,ind| puts "#{ind+1}. #{us.name}"}
    end
    puts "Would u like more info about a Strain? (y/n)"
    userinput = gets.chomp.downcase
      if userinput == "y"
        favorites_info(ustrain)
      else
        puts "ok.. moving along.."
        main_menu
      end
    ustrain
  end


      def favorites_info(array)
          houseArr = array
          array.each_with_index {|us,ind| puts "#{ind+1}. #{us.name}"}
          puts "Select the strain to find more info"
          input = gets.chomp
          input = input.to_i
          input -= 1
          array.each_with_index do |us,ind|
            if input == ind
              puts "name: #{us.name}"
              puts "race: #{us.race.capitalize}"
              puts "flavors: #{us.flavors}"
              puts "Vibe effects:#{us.positive_effects}"
              puts "may alleviate discomfort from: #{us.medical.gsub(/ Lack of Appetite,/,"")}"
              sleep(1)
              puts "Would u like to..."
              puts "1. Learn more about your favorites"
              puts "2. Return to Main Menu"
                newput = gets.chomp.to_i
                if newput == 1
                  view_favorite_strains(houseArr)
                elsif newput == 2
                  main_menu
                end
             end
           end
        main_menu
    end



def run
sign_in_or_sign_up
main_menu
end


end

# puts "puts do you want to add Strain of the Day to favorites"
# current_US = UserStrain.find_by(user_id: @user.id)
# if current_US == nil
#   UserStrain.create(user_id: @user.id, strain_id: strain.id)
#   puts "#{strain.name} has been added to your favorites"
# elsif !(current_US.user.strains.include? (strain))
#     UserStrain.create(user_id: @user.id, strain_id: strain.id)
#     puts "#{strain.name} has been added to your favorites"
# elsif current_US.user.strains.include? (strain)
#     puts "#{strain.name} is already in your favorites"
#   end
