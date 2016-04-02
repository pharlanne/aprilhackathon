require_relative('../models/account')


get "/" do
  options = { "transactions" => Transaction.all, "merchants" => Merchant.all, "tags" => Tag.all, "income" => Income.all, "targets" => Target.all }
  @account = Account.new(options)
  erb :main
end
