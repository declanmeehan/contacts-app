require 'unirest'
require 'tty-table'
require 'tty-prompt'
require 'pp'

while true
  system "clear"

  params = {}

  puts "Please enter one of the following commands:"
  puts "[1] show all contacts"
  puts "[1.1] seach a contacts first name: "
  puts "[2] create a contact"
  puts "[3] show a contacts"
  puts "[4] update a contact"
  puts "[5] delete a contact"
  puts "[signup] to create a new user"
  puts "[login] log in"
  puts "[logout] log out"
  puts "[q] Quit"
  answer_crud = gets.chomp

  if answer_crud == "1"
    response = Unirest.get("http://localhost:3000/v1/contacts")
    body = response.body
    pp body
  elsif answer_crud == "1.1"
    print "enter a first name to search:"
    search_first_name = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/contacts?search=#{search_first_name}")
    body = response.body
    pp body
  elsif answer_crud == "2"
    print "enter contacts first name: "
    params["first_name"] = gets.chomp
    print "enter contacts last_name: "
    params["last_name"] = gets.chomp
    print "enter contacts phone_number: "
    params["phone_number"] = gets.chomp
    print "enter contacts email"
    params["email"] = gets.chomp
     print "enter contacts middle_name"
    params["middle_name"] = gets.chomp
     print "enter contacts bio"
    params["bio"] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/contacts", parameters: params)
    body = response.body
    p body
  elsif answer_crud == "3" 
    puts "please enter an id number"
    answer_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/contacts/#{answer_id}")
  elsif answer_crud == "4"
    params = {}
    print "enter a the contacts id that you would like to update: "
    answer_update = gets.chomp
     print "enter contacts first name: "
    params["first_name"] = gets.chomp
    print "enter contacts last_name: "
    params["last_name"] = gets.chomp
    print "enter contacts phone_number: "
    params["phone_number"] = gets.chomp
    print "enter contacts email"
    params["email"] = gets.chomp
     print "enter contacts middle_name: "
    params["middle_name"] = gets.chomp
     print "enter contacts bio: "
    params["bio"] = gets.chomp
    response = Unirest.patch("http://localhost:3000/v1/contacts/#{answer_update}", parameters: params)
    body = response.body
    pp body
  elsif answer_crud == "5"
    print "what contacts would you like to delete? "
    answer_delete = gets.chomp
    response = Unirest.delete("http://localhost:3000/v1/contacts/#{answer_delete}")
  elsif answer_crud == "signup"
    params = {}
    puts "Enter name"
    params[:name] = gets.chomp
    puts "enter email"
    params[:email] = gets.chomp
    puts "enter password"
    params[:password] = gets.chomp
    puts " Please re-enter password"
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("https://localhost:3000/v1/users", parameters: params)
    pp response.body
  elsif answer_crud == "login"
    params = {}
    puts "enter email:"
    params[:email] = gets.chomp
    puts "enter password"
    params[:password] = gets.chomp
    response = Unirest.post(
      "http://localhost:3000/user_token", parameter: {auth: {email: params[:email], password: params[:password]}}
    )
    pp response.body
    jwt = response.body["jwt"]
    Unirest.default_header("Authorization", "bearer #{jwt}")
  elsif
    input_option == "logout"
    jwt = ""
    Unirest.clear_default_headers()
  elsif answer_crud == "q"
    break
  else 
    puts "Next time enter a valid number you dummy"
  end
  puts 
  puts "Press enter to continue"
  gets.chomp
end

