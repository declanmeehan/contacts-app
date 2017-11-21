require "unirest"
response = Unirest.get"http://localhost:3000/contact1"
bod1 = response.body
response = Unirest.get"http://localhost:3000/contact2"
bod2 = response.body
response = Unirest.get"http://localhost:3000/contact3"
bod3 = response.body

p "#{bod1} + #{bod2} + #{bod3}"