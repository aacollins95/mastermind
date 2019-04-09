class Game
  def initialize
    @ans = gen_answer
    @guesses = []
    @game_over = false
    @end_condition = 0
    draw_intro
    run
  end

  def draw_intro
    #draws introductory information to the console
    puts "MASTERMIND - console edition"
    puts "\nThe computer has generated a code"
    puts "Guess a 4 letter combination of the following: ABCDEF"
  end

  def gen_answer
    #randomly generates a 4 digit code (ABCDEF)
    code = []
    code_len = 4
    code_len.times {code.push(rand(65..70).chr)}
    return code.join
  end

  def run
    #runs the game, checks for completion and whatnot
    until @game_over
      @guesses.push(Guess.new(@ans))
      @guesses.each { |g|
        g.draw
      }
      check_endgame
    end
    draw_gameover
  end

  def check_endgame
    #determines the way the game ended (if it has) and tells Game it's over
    @game_over = true
    if @guesses.last.hits == 4
      @end_condition = 'Win'
    elsif @guesses.length > 11
      @end_condition = 'Lose'
    else
      @game_over = false
    end
  end

  def draw_gameover
    if @end_condition == 'Win'
      puts "Congratulations, you're a winner!"
    else
      puts "LOSER"
    end
  end


end

class Guess

  attr_reader :hits

  private
  def initialize(ans)
    #each guess should be made of ABCDEF
    @guess = input_guess
    compare(ans)
  end

  def compare(ans)
    #gets hits and misses from a certain answer string
    hits = 0
    misses = 0
    code = ans.split("")
    code_copy = code
    @guess.split("").each_with_index { |val,index|
      if val == code[index]
        hits += 1
      elsif code_copy.include? val
        code_copy.delete(val)
        misses += 1
      end
    }
    @hits,@misses = hits, misses
  end

  def input_guess
    #gets a clean guess
    valid = false
    until valid
      prelim = gets.chomp
      size = (prelim.length == 4)
      chars = prelim.split("").all? {|c| c.ord >= 65 && c.ord < 71}
      if size && chars
        valid = true
      else
        puts "Please input a 4 letter combination of ABCDEF"
      end
    end
    return prelim

  end

  public
  def draw
    #display guess information
    puts "Guess: #{@guess} \t\t\t\t Hits: #{@hits} Misses: #{@misses}"
  end
end

Game.new
