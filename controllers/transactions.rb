require "sinatra"
require "sinatra/contrib/all"
require_relative "../models/account"

# Display all transactions.
get "/transactions" do
  if params[ :filter ] == "month"
    options = {
      "transactions" => Transaction.find_this_month,
      "merchants" => Merchant.all,
      "tags" => Tag.all,
      "income" => Income.all,
      "targets" => Target.all
    }
  else
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  end
  @account = Account.new( options )
  if @account.transactions.size == 0
    erb :"/transactions/empty"
  else
    erb :"/transactions/index"
  end
end

# Create a new transaction.
get "/transactions/new" do
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  erb :"/transactions/new"
end

# Display additional information about and all transactions for a single transaction.
get "/transactions/:id" do
  @transaction = Transaction.find( params[ :id ])
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  erb :"/transactions/show"
end

# Post new transaction.
post "/transactions" do
  @transaction = Transaction.create( params )
  redirect to "/transactions"
end

# Edit a transaction.
get "/transactions/:id/edit" do
  @transaction = Transaction.find( params[ :id ])
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  erb :"/transactions/edit"
end

# Post edited transaction.
post "/transactions/:id" do
  @transaction = Transaction.new( params )
  @transaction.update
  redirect to "/transactions"
end

# Post deleted transaction.
post "/transactions/:id/delete" do
  Transaction.destroy( params[ :id ])
  redirect to "/transactions"
end