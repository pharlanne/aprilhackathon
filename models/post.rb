require_relative "../db/sql_runner"

class Post
  attr_reader :response, :post_date, :reputation

  def initialize( params )
    @id = nil || params[ "id" ].to_i
    @response = params[ "title" ]
    @post_date = params[ "post_date" ]
    @reputation = params[ "reputation" ].to_i
  end

  def self.find( id )
   query = "SELECT * FROM Posts WHERE id = #{ id.to_i }"
   result = SqlRunner.execute( query )
   return Post.new( result[ 0 ])
  end

  def self.all
    query = "SELECT * FROM Posts ORDER BY post_date DESC"
    posts = SqlRunner.execute( query )
    return posts.map { |t| Post.new( t )}
  end

  def self.create( params )
    query = "INSERT INTO Posts ( response, post_date, reputation )
    VALUES (
      '#{ params[ "response" ] }',
      '#{ params[ "post_date" ]}'
    )"
    SqlRunner.execute( query )
    return Post.new( Post.last_entry )
  end

  def update
    query = "UPDATE Posts SET response = '#{ @response }', post_date = '#{ @post_date }' WHERE id = #{ @id }"
    return SqlRunner.execute( query )
  end

  def self.last_entry
    query = "SELECT * FROM Posts ORDER BY id DESC limit 1;"
    return SqlRunner.execute( query )[ 0 ]
  end

  def self.destroy( id )
    SqlRunner.execute( "DELETE FROM Posts WHERE id = #{ id }" )
  end

  def self.delete_all 
    query = "DELETE FROM Posts"
    SqlRunner.execute( query )
  end
end