require "sinatra"
require "sinatra/contrib/all"
require_relative "../models/account"

# Display all incomes.
get "/income" do
  if params[ :filter ] == "month"
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }

  @account = Account.new( options )
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
    erb :"/incomes/empty"
  else
    erb :"/incomes/index"
  end
end

# Create a new income.
get "/income/new" do
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  erb :"/incomes/new"
end

# Post new income.
post "/income" do
  @transaction = Income.create( params )
  redirect to "/income"
end

# Edit an income.
get "/income/:id/edit" do
  @income = Income.find( params[ :id ])
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  erb :"/incomes/edit"
end

# Post edited income.
post "/income/:id" do
  @income = Income.new( params )
  @income.update
  redirect to "/income"
end

# Post deleted comment.
post "/income/:id/delete" do
  Income.destroy( params[ :id ])
  redirect to "/income"
end