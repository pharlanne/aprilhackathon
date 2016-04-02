class RandomQuote
  attr_reader :message

  def initialize()
    quotes = ["Getting nearer - Awsome!","You're doing great!","Almost there - Keep Going"]
    @message = quotes.sample
  end
end