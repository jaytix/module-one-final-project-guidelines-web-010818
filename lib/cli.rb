class CLI

  def welcome
    puts "Welcome to our app"
    puts "what is your name?"
    input = gets.chomp
    input
  end

  def create_new_user(input)
    new_user = User.create(name: input)
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
      first_ailemnt_method
    when "2"
      #good vibes method"
    when "3"
      #search method
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

  def aliments
    #user can choose from list of aliments
    #save variable
  end

  def trending_strains

  end



  def list_of_ailments
    puts "1.Insomnia 2.Pain 3.Stress 4.Lack of Appetite"
    puts "5.Nausea 6.Fatigue 7.Headache 8.Muscle Spasms"
    puts "9.Depression 10.Cramps 11.Inflammation 12.Eye Pressure"
    puts "Please enter the number that cooresponds with your discomfort."
  end

  def choice
  input = gets.chomp
  input
  end

  def retrieve_user_strains(array)
    array.each_with_index {|strain,indx| puts "#{indx+1}.#{strain.name}"}
    array
  end

  def first_ailemnt_method
    ailments_arr = ["","Insomnia","Pain","Stress","Lack of Appetite","Nausea","Fatigue",
     "Headache","Muscle Spasms","Depression","Cramps","Inflammation","Eye Pressure"]
    puts "What seems to be bothering you?"
    list_of_ailments
    choice
    ailments_arr.each_with_index do |ailment,ind|
    if choice.to_i == ind
      puts "#{ailment}"
      user_ailmentStrain_arr = Strain.all.select { |strain| strain.medical.include?(ailment)}
    else
      puts "make another selection"
      first_ailemnt_method
      end
    end
    puts "These strains may be helpful"
    retrieve_user_strains(user_ailmentStrain_array) #Return va;ue is UserStrainArr
  end

  def anything_else
    puts "is there anything else bothering you?(y/n)"
    choice
    if choice.downcase == "y"
      list_of_ailments
      another_ailment_method
    elsif choice.downcase == "n"
      puts "choose a strain to add to your favorites"
      favorites_method(first_ailemnt_method)
    else
      puts "I don't think we can help with that. Make another selection"
      anything_else
    end
  end

  def another_ailment_method
    choice
    ailments_Array.each_with_index do |ailment,ind|
      if choice.to_i == ind
        puts "#{ailment}"
        second_ailmentStrain_arr = user_ailmentStrain_array.select {|strain| strain.medical.include?(ailment)}
      else
        puts "I don't think we can help with that. Make another selection"
        another_ailment_method
      end
    end
    puts "We Recommend these strains for what ails you"
    retrieve_user_strains(second_ailmentStrain_arr) #return value is 2ndStrainArr
  end

  def strain_of_the_day
    random_strain = Strain.all.sample
    puts random_strain.name
    puts random_strain.race
  end

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

  def run
  input = welcome
  user = create_new_user(input)
  puts "Welcome #{user.name.titleize}"
  main_menu
  end


end
