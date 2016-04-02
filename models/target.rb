require_relative "../db/sql_runner"
require "date"

class Target
  attr_reader :id, :amount, :target_date, :image_url

  def initialize( params )
    @id = nil || params[ "id" ].to_i
    @amount = params[ "amount" ].to_f
    @target_date = params[ "target_date" ]
    @image_url = params[ "image_url" ]
  end

  def date_format
    date = @target_date.to_s.split("-")
    return "#{ date[ 2 ]}/#{ date[ 1 ]}/#{ date[ 0 ]}"
  end

  def amount_format
    return sprintf "%.2f", @amount
  end

  def self.find( id )
   query = "SELECT * FROM Targets WHERE id = #{ id.to_i }"
   result = SqlRunner.execute( query )
   return Target.new( result[ 0 ])
  end

  def self.find_this_month
    query = "SELECT * FROM Targets
    WHERE DATE_PART ( 'month', target_date )
      = '#{ Time.now.strftime( "%m" )}'
    ORDER BY target_date DESC"
    targets = SqlRunner.execute( query )
    return targets.map { |t| Target.new( t )}
  end

  def self.all
    query = "SELECT * FROM Targets ORDER BY target_date DESC"
    targets = SqlRunner.execute( query )
    return targets.map { |t| Target.new( t )}
  end

  def self.create( params )
    query = "INSERT INTO Targets ( amount, target_date, image_url )
    VALUES (
      #{ params[ "amount" ]},
      '#{ params[ "target_date" ]}',
      #{ params[ "image_url" ]}
    )"
    SqlRunner.execute( query )
    return Target.new( Target.last_entry )
  end

  def update
    query = "UPDATE Targets SET amount = #{ @amount }, target_date = '#{ @target_date }', image_url = '#{ @image_url }' WHERE id = #{ @id }"
    return SqlRunner.execute( query )
  end

  def self.last_entry
    query = "SELECT * FROM Targets ORDER BY id DESC limit 1;"
    return SqlRunner.execute( query )[ 0 ]
  end

  def self.destroy( id )
    SqlRunner.execute( "DELETE FROM Targets WHERE id = #{ id }" )
  end

  def self.delete_all 
    query = "DELETE FROM Targets"
    SqlRunner.execute( query )
  end
end