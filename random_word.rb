require 'uri'
require 'net/http'
require 'httparty'

def get_random
  puts "loading..."
uri = HTTParty.get('https://fourtytwowords.herokuapp.com/words/randomWord?api_key=be45adfee7c617ff1b22a4ffccdf2687a8b7f484d1fc0603388c9f5d51879871e6fa92b0cb6fa6915f86e5c59d2c815b45496db11041a065ff6339318c925201')
 begin
   if uri.code != 200
  raise "#{uri.code} Error in finding words :( "
   end
 rescue => exception
  puts exception
 end
word=uri.body
newWord=JSON.parse(word)
newWord["id"]
end
