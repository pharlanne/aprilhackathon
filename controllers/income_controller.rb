require_relative('../models/account')




get '/income/new' do
  erb :""
end

post '/income' do
  redirect to('/')
end