require_relative "../db/sql_runner"
require "date"

class Transaction
  attr_reader :id, :merchant_id, :tag_id, :amount, :transaction_date

  def initialize( params )
    @id = nil || params[ "id" ].to_i
    @merchant_id = nil || params[ "merchant_id" ].to_i
    @tag_id = nil || params[ "tag_id" ].to_i
    @amount = params[ "amount" ].to_f
    @transaction_date = params[ "transaction_date" ]
  end

  def date_format
    date = @transaction_date.to_s.split("-")
    return "#{ date[ 2 ]}/#{ date[ 1 ]}/#{ date[ 0 ]}"
  end

  def amount_format
    return sprintf "%.2f", @amount
  end

  def self.find( id )
   query = "SELECT * FROM Transactions WHERE id = #{ id.to_i }"
   result = SqlRunner.execute( query )
   return Transaction.new( result[ 0 ])
  end

  def self.find_this_month
    query = "SELECT * FROM Transactions
    WHERE DATE_PART ( 'month', transaction_date )
      = '#{ Time.now.strftime( "%m" )}'
    ORDER BY transaction_date DESC"
    transactions = SqlRunner.execute( query )
    return transactions.map { |t| Transaction.new( t )}
  end

  def self.all
    query = "SELECT * FROM Transactions ORDER BY transaction_date DESC"
    transactions = SqlRunner.execute( query )
    return transactions.map { |t| Transaction.new( t )}
  end

  def self.create( params )
    query = "INSERT INTO Transactions ( amount, transaction_date, merchant_id, tag_id )
    VALUES (
      #{ params[ "amount" ]},
      '#{ params[ "transaction_date" ]}',
      #{ params[ "merchant_id" ]},
      #{ params[ "tag_id" ]}
    )"

    SqlRunner.execute( query )
    return Transaction.new( Transaction.last_entry )
  end

  def update
    query = "UPDATE Transactions SET amount = #{ @amount }, transaction_date = '#{ @transaction_date }' WHERE id = #{ @id }"
    return SqlRunner.execute( query )
  end

  def self.last_entry
    query = "SELECT * FROM Transactions ORDER BY id DESC limit 1;"
    return SqlRunner.execute( query )[ 0 ]
  end

  def self.destroy( id )
    SqlRunner.execute( "DELETE FROM Transactions WHERE id = #{ id }" )
  end

  def self.delete_all 
    query = "DELETE FROM Transactions"
    SqlRunner.execute( query )
  end
end