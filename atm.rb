# I'll be in the street and I realise I need to withdraw $100 from an atm.

class Atm
  # An atm has ... ?

  def initialize()
    @current_atm_balance = 100000
  end

  # An atm can .. ?

  def dispense(amount)
    if @current_balance > amount
      @current_balance = @current_balance - amount
      puts "I gave you $#{amount}"
    else
      puts "fuck off"
    end
  end

  def deposit(amount)
    @current_atm_balance = @current_atm_balance + amount
    puts "You've deposited $#{amount} in this atm"
  end



  attr_accessor  :current_atm_balance

  def self.all
    ObjectSpace.each_object(self).to_a
  end
end
################################
class Person
  # Person has .. ?

attr_accessor :money_available_on_your_account

  def initialize(balance)
    @money_available_on_your_account = balance

  end

  # What can a person do?

  def withdraw(amount, atm)
    atm.dispense(amount)
    @balance = @balance - amount
  end

  def deposit(amount, atm)
    atm.deposit(amount)
    @balance = @balance + amount
  end

end

########################### Choose between deposit and withdraw
puts "'Withdraw'=1 or 'Deposit'=2?"
user_choice = gets.chomp.to_i

################################ Deposit
if user_choice == 2
  puts "Amount you would like to deposit?"
  amount_deposit = gets.chomp.to_i


  carole = Person.new(800)
  atm = Atm.new()
  carole.deposit(amount_deposit, atm)
  
  # money_available_on_your_account = money_available_on_your_account + amount_deposit

  # puts "You've deposited #{amount_deposit} in your account and you have a grand total of #{money_available}"

################################# withdraw
elsif user_choice == 1
  puts "What amount would you like to withdraw?"
  wishful_cash = gets.chomp.to_i

else
  puts "please type either 1 or 2, or to escape ^C"

end
