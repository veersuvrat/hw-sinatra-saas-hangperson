class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(letter)
    if letter.nil? or letter == "" or (not letter[/[a-zA-Z]+/]  == letter)
      raise ArgumentError
    end
    if @word.downcase.include? letter.downcase
      if @guesses.include? letter.downcase
        return false
      else
        @guesses.concat(letter.downcase)
      end
    else
      if @wrong_guesses.include? letter.downcase
        return false
      else
        @wrong_guesses.concat(letter.downcase)
      end
    end
    return true
  end
  
  def word_with_guesses
    rtrn_str = ""
    @word.split("").each do |i|
      if @guesses.include? i
        rtrn_str = rtrn_str + i
      else
        rtrn_str = rtrn_str + "-"
      end
    end
    return rtrn_str
  end
  
  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
