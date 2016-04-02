require "sinatra"
require "sinatra/contrib/all" if development?
require_relative "controllers/advice"
require_relative "controllers/income"
require_relative "controllers/login"
require_relative "controllers/merchants"
require_relative "controllers/tags"
require_relative "controllers/transactions"
require_relative "models/random_quote"

get "/" do
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }

  @account = Account.new( options )
  @target = @account.targets[ 0 ]
  @quote = RandomQuote.new()

  if @account.targets.size == 0
    erb :home_new_user
  else
    erb :home
  end
end

not_found do
  status 404
  erb :"errors/404"
end