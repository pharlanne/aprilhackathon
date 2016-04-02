require_relative "../db/sql_runner"

class User
  attr_reader :username, :reputation, :avatar

  def initialize( params )
    @id = nil || params[ "id" ].to_i
    @title = params[ "title" ]
    @question_date = params[ "reputation" ].to_i
    @avatar = params[ "avatar" ]
  end

  def self.find( id )
   query = "SELECT * FROM Questions WHERE id = #{ id.to_i }"
   result = SqlRunner.execute( query )
   return Question.new( result[ 0 ])
  end

  def self.all
    query = "SELECT * FROM Questions ORDER BY question_date DESC"
    questions = SqlRunner.execute( query )
    return questions.map { |t| Question.new( t )}
  end

  def self.create( params )
    query = "INSERT INTO Questions ( username, reputation, image_url )
    VALUES (
      '#{ params[ "username" ] }',
      #{ params[ "reputation" ]},
      '#{ params[ "image_url" ]}'
    )"
    SqlRunner.execute( query )
    return User.new( User.last_entry )
  end

  def update
    query = "UPDATE Users SET username = '#{ @username }', reputation = #{ @reputation }, avatar = '#{ @avatar }' WHERE id = #{ @id }"
    return SqlRunner.execute( query )
  end

  def self.last_entry
    query = "SELECT * FROM Users ORDER BY id DESC limit 1;"
    return SqlRunner.execute( query )[ 0 ]
  end

  def self.destroy( id )
    SqlRunner.execute( "DELETE FROM Users WHERE id = #{ id }" )
  end

  def self.delete_all 
    query = "DELETE FROM Users"
    SqlRunner.execute( query )
  end

end