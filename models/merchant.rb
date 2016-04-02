require_relative "../db/sql_runner"

class Merchant
  attr_reader :id, :name

  def initialize( params )
    @id = nil || params[ "id" ].to_i
    @name = params[ "name" ]
  end

  def self.find( id )
   query = "SELECT * FROM Merchants WHERE id = #{ id.to_i }"
   result = SqlRunner.execute( query )
   return Merchant.new( result[ 0 ])
  end

  def self.find_where( name )
    query = "SELECT * FROM Merchants
    WHERE LOWER(name)
    LIKE '%#{ name.downcase }%'
    ORDER BY name ASC"
    merchants = SqlRunner.execute( query )
    return merchants.map { |m| Merchant.new( m )}
  end

  def self.all
    query = "SELECT * FROM Merchants ORDER BY name ASC"
    merchants = SqlRunner.execute( query )
    return merchants.map { |m| Merchant.new( m )}
  end

  def self.create( params )
    query = "INSERT INTO Merchants ( name ) VALUES ( '#{ params[ 'name' ]}' )"
    SqlRunner.execute( query )
    return Merchant.new( Merchant.last_entry )
  end

  def update
    query = "UPDATE Merchants SET name = '#{ @name }' WHERE id = #{ @id }"
    return SqlRunner.execute( query )
  end

  def self.last_entry
    query = "SELECT * FROM Merchants ORDER BY id DESC limit 1;"
    return SqlRunner.execute( query )[ 0 ]
  end

  def self.delete_all 
    query = "DELETE FROM Merchants"
    SqlRunner.execute( query )
  end
end