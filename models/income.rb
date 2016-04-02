require_relative "../db/sql_runner"
require "date"

class Income
  attr_reader :id, :amount, :income_date

  def initialize( params )
    @id = nil || params[ "id" ].to_i
    @amount = params[ "amount" ].to_f
    @income_date = params[ "income_date" ]
  end

  def date_format
    date = @income_date.to_s.split("-")
    return "#{ date[ 2 ]}/#{ date[ 1 ]}/#{ date[ 0 ]}"
  end

  def amount_format
    return sprintf "%.2f", @amount
  end

  def self.find( id )
   query = "SELECT * FROM Incomes WHERE id = #{ id.to_i }"
   result = SqlRunner.execute( query )
   return Income.new( result[ 0 ])
  end

  def self.find_this_month
    query = "SELECT * FROM Incomes
    WHERE DATE_PART ( 'month', income_date )
      = '#{ Time.now.strftime( "%m" )}'
    ORDER BY income_date DESC"
    incomes = SqlRunner.execute( query )
    return incomes.map { |t| Income.new( t )}
  end

  def self.all
    query = "SELECT * FROM Incomes ORDER BY income_date DESC"
    incomes = SqlRunner.execute( query )
    return incomes.map { |t| Income.new( t )}
  end

  def self.create( params )
    query = "INSERT INTO Incomes ( amount, income_date )
    VALUES (
      #{ params[ "amount" ]},
      '#{ params[ "income_date" ]}'
    )"

    SqlRunner.execute( query )
    return Income.new( Income.last_entry )
  end

  def update
    query = "UPDATE Incomes SET amount = #{ @amount }, income_date = '#{ @income_date }' WHERE id = #{ @id }"
    return SqlRunner.execute( query )
  end

  def self.last_entry
    query = "SELECT * FROM Incomes ORDER BY id DESC limit 1;"
    return SqlRunner.execute( query )[ 0 ]
  end

  def self.destroy( id )
    SqlRunner.execute( "DELETE FROM Incomes WHERE id = #{ id }" )
  end

  def self.delete_all 
    query = "DELETE FROM Incomes"
    SqlRunner.execute( query )
  end
end