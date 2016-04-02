require_relative('../models/account')
require_relative('../models/random_quote')


get "/" do
  options = { "transactions" => Transaction.all, "merchants" => Merchant.all, "tags" => Tag.all, "income" => Income.all, "targets" => Target.all }
  @account = Account.new(options)
  @quote = RandomQuote.new()
  erb :main
end
