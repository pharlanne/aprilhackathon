require_relative('../account')
require_relative('../income')
require_relative('../merchant')
require_relative('../question')
require_relative('../tag')
require_relative('../target')
require_relative('../transaction')
require_relative('../user')

get "/" do
  @income = Income.all
  @transaction = Transaction.all
  @target = Target.all
  erb:""
end
