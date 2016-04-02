require_relative "../models/account"

get 'transactions/new' do
  options = { 'transactions' => Transaction.all, "merchants" => Merchants.all, "tags" => Tags.all, "income" => Income.all }
  @account = Account.new(options)
  erb :"transactions/new"
end

post 'transactions' do
  @transaction = Transaction.new
  @transaction.create
  redirect to ('transactions/new')
end