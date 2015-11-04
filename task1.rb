# Task 1: A Monetary Calculation
 
# If you have $200 in your pocket, and you see a shelf with a long row of foobars priced at $1, $1.2, $1.44, $1.73 and so forth. Every foobar costs 20% more than the previous one. You buy one of each foobar, starting with the one that costs $1, until you can't afford the next foobar on the self (the foobars are ordered by price). How many foobars can you buy, and how much change will you get? Your task is to write a small routine to solve this problem, and report the results.
                                                                                                                                                                                                                                                        
# Note: Since we are talking about money (dollars and cents), there are only two decimals used in each price.

# object-oriented solution:
class FooBarShopping

  def initialize(initial_foobar_px,percentage_px_increase,initial_amount_to_spend)
    @initial_foobar_px = initial_foobar_px
    @percentage_px_increase = percentage_px_increase
    @initial_amount_to_spend = initial_amount_to_spend
    @foobar_array = Array.new
  end

  def shop
    run_calculation_logic
    print_calculation_outcome
  end

  private

  def print_calculation_outcome
    puts "You started with $#{@initial_amount_to_spend}."
    puts "Each subsequently bought foobar was #{round_off_percentage_px_increase}% more expensive than a previous one."
    puts "You bought a total of #{count_foobars_bought} foobars at a total cost of $#{calculate_money_spent}."
    puts "You will get $#{calculate_change} in change."
  end

  def run_calculation_logic
    @foobar_array << @initial_foobar_px
    until calculate_running_total_left<0 do
      calculate_price_of_next_foobar
      @foobar_array << @initial_foobar_px
    end
  end

  # this assumes that each subsequent price is rounded off to 2 digits immediately to imitate real life
  def calculate_price_of_next_foobar
    @initial_foobar_px = (@initial_foobar_px * (1+@percentage_px_increase)).round(2)
  end

  def calculate_running_total_left
    @initial_amount_to_spend-calculate_running_total_spent
  end

  def calculate_running_total_spent
    @foobar_array.reduce(0, :+)
  end

  def count_foobars_bought
    @foobar_array.size-1
  end

  def calculate_money_spent
    @foobar_array[0..-1-1].reduce(0, :+).round(2)
  end

  def calculate_change
    (@initial_amount_to_spend - calculate_money_spent).round(2)
  end

  def round_off_percentage_px_increase
    (@percentage_px_increase*100).round
  end

end

# initialize with:
 # * starting foobar price as integer
 # * % px increase as a decimal 
 # * total $ to be spent as integer
a = FooBarShopping.new(1,0.2,200)
a.shop

# run this code with 'ruby task1.rb' if ruby is installed || or via https://repl.it/languages/Ruby

