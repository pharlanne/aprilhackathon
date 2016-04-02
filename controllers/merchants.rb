require "sinatra"
require "sinatra/contrib/all"
require_relative "../models/account"

# Display all merchants.
get "/merchants" do
  if params[ :search ]
    options = {
      "transactions" => Transaction.find_this_month,
      "merchants" => Merchant.find_where( params[ :search ]),
      "tags" => Tag.all,
      "income" => Income.all,
      "targets" => Target.all
    } 
  else
    options = {
      "transactions" => Transaction.find_this_month,
      "merchants" => Merchant.all,
      "tags" => Tag.all,
      "income" => Income.all,
      "targets" => Target.all
    }
  end
  @account = Account.new( options )
  if @account.merchants.size == 0
    erb :"merchants/empty"
  else
    erb :"merchants/index"
  end
end

# Create a new merchant.
get "/merchants/new" do
  erb :"merchants/new"
end

# Display additional information about and all transactions for a single merchant.
get "/merchants/:id" do
  @merchant = Merchant.find( params[ :id ])  
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  if @account.transactions.select { |t| t.merchant_id == @merchant.id }.size == 0
    erb :"merchants/show_empty"
  else
    erb :"merchants/show"
  end
end

# Post new merchant.
post "/merchants" do
  @merchant = Merchant.create( params )
  redirect to "/merchants"
end

# Edit a merchant.
get "/merchants/:id/edit" do
  @merchant = Merchant.find( params[ :id ])
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  erb :"merchants/edit"
end

# Post edited merchant.
post "/merchants/:id" do
  @merchant = Merchant.new( params )
  @merchant.update
  redirect to "/merchants"
end