require "minitest/autorun"
require "minitest/rg"
require_relative "../models/account"

class TestAccount < MiniTest::Test
  def setup
    merchant = Merchant.new( "id" => 1,"name" => "Tesco" )
    merchants = [ merchant ]

    tag = Tag.new( "id" => 1, "name" => "Groceries", "monthly_budget" => 250.00 )
    tags = [ tag ]

    transaction1 = Transaction.new(
      "merchant_id" => 1,
      "tag_id" => 1,
      "amount" => 100,
      "transaction_date" => "2016-04-1"
      )
    transaction2 = Transaction.new(
      "merchant_id" => 1,
      "tag_id" => 1,
      "amount" => 50,
      "transaction_date" => "2016-04-1"
      )
    transactions = [ transaction1, transaction2  ]

    target = Target.new( "amount" => 1000, "target_date" => 2016-07-18, "image_url" => "" )
    targets = [ target ]

    params = { "transactions" => transactions, "merchants" => merchants, "tags" => tags, "targets" => targets }
    @account = Account.new( params )
  end

  def test_transaction_amount
    assert_equal( 100, @account.transactions[ 0 ].amount )
  end

  def test_transaction_date
    assert_equal( "2016-04-1", @account.transactions[ 0 ].transaction_date )
  end

  def test_merchant_name
    assert_equal( "Tesco", @account.merchants[ 0 ].name )
  end

  def test_tag_name
    assert_equal( "Groceries", @account.tags[ 0 ].name )
  end

  def test_target_amount
    assert_equal( 1000, @account.targets[ 0 ].amount )
  end

  def test_transaction_total
    assert_equal(( sprintf "%0.2f", 150.00 ), @account.transaction_total )
  end

  def test_merchant_total
    assert_equal(( sprintf "%0.2f", 150.00 ), @account.merchant_total( 1 ))
  end

  def test_merchant_average
    assert_equal( "75.00", @account.merchant_average( 1 ))
  end

  def test_tag_total
    assert_equal( "150.00", @account.tag_total( 1 ))
  end

  def test_tag_average
    assert_equal( "75.00", @account.tag_average( 1 ))
  end

  def test_merchant_number
    assert_equal( 2, @account.merchant_number( 1 ))
  end

  def test_tag_number
    assert_equal( 2, @account.tag_number( 1 ))
  end

  def test_top_merchant
    assert_equal([ "Tesco", 150.0 ], @account.top_merchant )
  end

  def test_top_merchant_format
    assert_equal( "150.00", @account.top_merchant_format )
  end

  def test_top_tag
    assert_equal([ "Groceries", 150.0 ], @account.top_tag )
  end

  def test_top_tag_format
    assert_equal( "150.00", @account.top_tag_format )
  end

  def test_budget_total
    assert_equal( "250.00", @account.budget_total )
  end
end