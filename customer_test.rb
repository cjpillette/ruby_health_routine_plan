require 'test/unit'
require_relative 'customer'

class CustomerTest < Test::Unit::TestCase

 def test_first_name
    customer = Customer.new('Ben', 'Lloyd')
    assert_equal('Ben', customer.first_name)
  end

 def test_last_name
    customer = Customer.new('Ben', 'Lloyd')
    assert_equal('Lloyd', customer.last_name)
  end

 def test_full_name
    customer = Customer.new('Ben', 'Lloyd')
    assert_equal('Ben Lloyd', customer.full_name)
    # assert false
  end

 def test_update_first_name
    customer = Customer.new('Ben', 'Lloyd')
    customer.update_first_name("Bob")
    assert_not_same(customer.first_name[1], customer.first_name[0])
  end

end
