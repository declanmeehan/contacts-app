require 'unirest'
require 'tty-table'
require 'tty-prompt'
require 'pp'

system "clear"

params = {}

puts "Please enter a number:"
puts "[1] show all contacts"
puts "[2] create a contact"
puts "[3] show a contacts"
puts "[4] update a contact"
puts "[5] delete a contact"
answer_crud = gets.chomp

if answer_crud == "1"
  response = Unirest.get("http://localhost:3000/v1/contacts")
  body = response.body
  pp body
elsif answer_crud == "2"
  print "enter contacts name: "
  params["name"] = gets.chomp
  print "enter contacts price: "
  params["price"] = gets.chomp
  print "enter contacts image: "
  params["image"] = gets.chomp
  print "enter contacts Description: "
  params["description"] = gets.chomp
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
  print "enter contacts name: "
  params["name"] = gets.chomp
  print "enter contacts price: "
  params["price"] = gets.chomp
  print "enter contacts image: "
  params["image"] = gets.chomp
  print "enter contacts Description: "
  params["description"] = gets.chomp
  response = Unirest.patch("http://localhost:3000/v1/contacts/#{answer_update}", parameters: params)
  body = response.body
  pp body
elsif answer_crud == "5"
  print "what contacts would you like to delete? "
  answer_delete = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/contacts/#{answer_delete}")
else 
  puts "Next time enter a valid number you dummy"
end
  

