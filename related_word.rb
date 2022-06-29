require 'uri'
require 'net/http'
require 'httparty'

def get_related(words)
uri = HTTParty.get("https://fourtytwowords.herokuapp.com/word/#{words}/relatedWords?api_key=be45adfee7c617ff1b22a4ffccdf2687a8b7f484d1fc0603388c9f5d51879871e6fa92b0cb6fa6915f86e5c59d2c815b45496db11041a065ff6339318c925201")
begin
  if uri.code != 200
    raise "error in finding similar types of words"
  end
rescue => exception
    puts exception
end
hash=Hash.new(0)
a=false
b=false
for i in 0...uri.length
  if uri[i]["relationshipType"]=="antonym"
    hash[0]=uri[i]["words"]
    a=true
  elsif uri[i]["relationshipType"]=="synonym"
    hash[1]=uri[i]["words"]
    b=true
  end
end
hash[0]=[] if !a
hash[1]=[] if !b 
return hash
end

#get_related("clear")
