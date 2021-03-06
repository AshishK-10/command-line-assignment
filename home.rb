$LOAD_PATH << '.'
require_relative 'random_word.rb'
require_relative 'word_defination.rb'
require_relative 'related_word.rb'
require_relative 'example.rb'


class WordDictionary

  def initialize
    @score=0 #initializing the score of the complete game
  end

 def play
  puts "starting the game" #main interface or method that opens to the user and handles all other methods
  puts " "
  start #starting the game
  hint(rand(1..3)) #randomising the hint before calling the hint method
  guess #method allows user to guess the answer
 end
 private #protecting these files from outside access
 def guess
  puts " "
  puts "Now make a guess.It may be a correct answer.: "
  g=gets.chomp.downcase

#if correct answer,points will be rewarded and game restarts
  if g == @key || check_for_syn(g)
    @score+=10
    puts "Correct answer!!"
    puts "-------------------------"
    puts "Your score is: #{@score}"
    puts "--------------------------"
    puts "Finding new word.."
    puts ""
    play

 #on wrong guess,options are displayed:
  else
    @score-=2
    puts "wrong answer"
    puts "-------------------------"
    puts "Your Score is: #{@score}"
    puts "--------------------------"
    puts "enter choice:"
    puts "1. Try again"
    puts "2. Another hint"
    puts "3. Skip this word"
    puts ". Press Any other key to exit the game"
    ch=gets.chomp.to_i
    guess if ch == 1
    hint(rand(1..3),true) if ch == 2
    skip if ch == 3
  end
 end

#method checks if user input is a synonym or not
 def check_for_syn(a)
  x=@syn.include?a
  y=@syn_so_far.include?a
  return x&&!y
 end

#skip method
 def skip
  @score-=4
  puts "------------------------"
  puts "Your Score is: #{@score}"
  puts "------------------------"
  puts "The word was: #{@key}"
  if @atm_len>0
    puts "Antonyms:"
    @atm.each{|x| puts x}
    puts " "
  end

  if @syn_len>0
    puts "Synonyms:"
    @syn.each{|x| puts x}
    puts " "
  end

  if @def.length>0
    puts "Definations of the word:"
    @def.each{|x| puts "=> #{x}"}
    puts " "
  end
  ex=get_example(@key)

  if ex.length>0
    puts "Some examples of the word: "
    ex.each{|x| puts "=> #{x}"}
    puts " "
  end
  play
 end

#method restarts the game
def start
  @key=get_random
  hash=get_related(@key)
  @atm=hash[0]
  @syn=hash[1]
  @def=get_defination(@key)
  @atm_so_far=[]
  @syn_so_far=[]
  @def_so_far=[]
  @atm_count=0
  @syn_count=0
  @def_count=0
  @atm_len=@atm.length
  @syn_len=@syn.length
  @def_len=@def.length
 end

#method provides hint when asked
 def hint(a,f=false)
  @score-=3 if f
  if a==1 && @atm_count<@atm_len
    puts "the antonym of the word is: #{@atm[@atm_count]}"
    @atm_so_far.push(@atm[@atm_count])
    @atm_count+=1

  elsif a==2 && @syn_count<@syn_len
    puts "the synonym of the word is: #{@syn[@syn_count]}"
    @syn_so_far.push(@syn[@syn_count])
    @syn_count+=1

  elsif a==3 && @def_count<@def_len
    puts "the Defination of the word is: #{@def[@def_count]}"
    @def_so_far.push(@def[@def_count])
    @def_count+=1

    #provides the jumbled string
  elsif @def_count>=@def_len && @atm_count>=@atm_len && @syn_count>= @syn_len
    arr=[]
    for i in 0..@key.length-1
      arr.push(@key[i])
    end
    arr.shuffle!
    s=""
    arr.each{|x| s+=x}
    print "The jumbled word is: #{s}"
    puts ""
  else
    hint(rand(1..3))
  end
  guess if f
 end
end



m=WordDictionary.new
m.play
