require_relative('../account')
require_relative('../income')
require_relative('../merchant')
require_relative('../question')
require_relative('../tag')
require_relative('../target')
require_relative('../transaction')
require_relative('../user')

get 'transaction/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb:"transaction/new"
end

post 'transaction' do
  @transaction = Transaction.new
  @transaction.create
  redirect to ('transaction/new')
end


