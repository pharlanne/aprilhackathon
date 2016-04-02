require "sinatra"
require "sinatra/contrib/all"
require_relative "../models/account"

# Create a new target.
get "/target/new" do
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  if @account.targets.size == 0
    erb :"/targets/new"
  else
    erb :"/errors/404"
end

# Post new target.
post "/target" do
  @merchant = Target.create( params )
  redirect to "/"
end

# Edit a target.
get "/target/:id/edit" do
  @merchant = Target.find( params[ :id ])
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  erb :"/targets/edit"
end

# Post edited target.
post "/target/:id" do
  @target = Target.new( params )
  @target.update
  redirect to "/"
end

# Post deleted target.
post "/target/:id/delete" do
  Target.destroy( params[ :id ])
  redirect to "/"
end