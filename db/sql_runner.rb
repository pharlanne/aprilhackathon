require "pg"

class  SqlRunner
  def self.execute( query )
    begin
      db = PG.connect( dbname: "database", host: "localhost" )
      result = db.exec( query )
    ensure
      db.close
    end
    return result
  end
end