require 'uri'
require 'net/http'
require 'httparty'

def get_defination(words)
uri = HTTParty.get("https://fourtytwowords.herokuapp.com/word/#{words}/definitions?api_key=be45adfee7c617ff1b22a4ffccdf2687a8b7f484d1fc0603388c9f5d51879871e6fa92b0cb6fa6915f86e5c59d2c815b45496db11041a065ff6339318c925201")
arr=[]
begin
if uri.code != 200
  raise "#{uri.code}: problem in finding code :("
end
rescue=>e
  arr.push("NO DEFINATION AVAILABLE")
  return arr
end
newWord=JSON.parse(uri.body)

for i in 0...newWord.length
word=newWord[i].to_s
word=word.split("=>")[1]
word=word.split("}")[0]
arr.push(word)
end
arr
end

