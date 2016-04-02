require_relative('../models/account')



get '/login'  do
  erb :'/login'
end

post 'login' do
  redirect to('/')
end