require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('controllers/advice_controller')
require_relative('controllers/income_controller')
require_relative('controllers/login_controller')
require_relative('controllers/main_controller')
require_relative('controllers/merchant_controller')
require_relative('controllers/tag_controller')
require_relative('controllers/transaction_controller')

get "/login" do
  erb :"login"
end