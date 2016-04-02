require_relative "../models/account"

get '/tag' do
  options = { "transactions" => Transaction.all, "merchants" => Merchants.all, "tags" => Tags.all, "income" => Income.all }
  @account = Account.new(options)
end