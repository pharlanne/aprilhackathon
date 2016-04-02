require_relative "../models/account"

# Display login form.
get '/login'  do
  erb :login
end

# Redirect to home on form submit.
post 'login' do
  redirect to('/')
end