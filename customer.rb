class Customer

 def initialize(first_name, last_name)
    @first_name = [first_name]
    @last_name = [last_name]
  end

 def first_name
    @first_name[-1]
  end

 def last_name
    @last_name[-1]
  end

 def full_name
    "#{@first_name[-1]} #{@last_name[-1]}"
  end

 def update_first_name(new_first_name)
    @first_name.push(new_first_name)
    puts "\n#{@first_name}"
  end

end
