require_relative "../db/sql_runner"

class Question
  attr_reader :title, :question_date

  def initialize( params )
    @id = nil || params[ "id" ].to_i
    @user_id || params[ "user_id" ].to_i
    @title = params[ "title" ]
    @question_date = params[ "question_date" ].to_i
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
    query = "INSERT INTO Questions ( title, question_date )
    VALUES (
      '#{ params[ "title" ] }',
      '#{ params[ "question_date" ]}'
    )"
    SqlRunner.execute( query )
    return Question.new( Question.last_entry )
  end

  def update
    query = "UPDATE Questions SET title = '#{ @title }', question_date = '#{ @question_date }' WHERE id = #{ @id }"
    return SqlRunner.execute( query )
  end

  def self.last_entry
    query = "SELECT * FROM Questions ORDER BY id DESC limit 1;"
    return SqlRunner.execute( query )[ 0 ]
  end

  def self.destroy( id )
    SqlRunner.execute( "DELETE FROM Questions WHERE id = #{ id }" )
  end

  def self.delete_all 
    query = "DELETE FROM Questions"
    SqlRunner.execute( query )
  end
end