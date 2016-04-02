require "sinatra"
require "sinatra/contrib/all"
require_relative "../models/account"

# Display all tags.
get "/tags" do
  if params[ :search ]
    options = {
      "transactions" => Transaction.find_this_month,
      "merchants" => Merchant.all,
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
  if @account.tags.size == 0
    erb :"/tags/empty"
  else
    erb :"/tags/index"
  end
end

# Create a new tag.
get "/tags/new" do
  erb :"/tags/new"
end

# Display additional information about and all transactions for a single tag.
get "/tags/:id" do
  @tag = Tag.find( params[ :id ])  
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  if @account.transactions.select { |t| t.tag_id == @tag.id }.size == 0
    erb :"tags/show_empty"
  else
    erb :"tags/show"
  end
end

# Post new tag.
post "/tags" do
  @tag = Tag.create( params )
  redirect to "/tags"
end

# Edit a tag.
get "/tags/:id/edit" do
  @tag = Tag.find( params[ :id ])
  options = {
    "transactions" => Transaction.all,
    "merchants" => Merchant.all,
    "tags" => Tag.all,
    "income" => Income.all,
    "targets" => Target.all
  }
  @account = Account.new( options )
  erb :"/tags/edit"
end

# Post edited tag.
post "/tags/:id" do
  @tag = Tag.new( params )
  @tag.update
  redirect to "/tags"
end