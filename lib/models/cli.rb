class CLI < ActiveRecord::Base

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
    when "2"
      #good vibes method"
    when "3"
      #search method
    when "4"
      #strain of the day method
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


end
