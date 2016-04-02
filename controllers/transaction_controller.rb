require_relative('../models/account')


get 'transaction/new' do
  options = { 'transactions' => Transaction.all, "merchants" => Merchants.all, "tags" => Tags.all, "income" => Income.all }
  @account = Account.new(options)
  erb :"transaction/new"
end

post 'transaction' do
  @transaction = Transaction.new
  @transaction.create
  redirect to ('transaction/new')
end


