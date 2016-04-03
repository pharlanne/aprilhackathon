require_relative "../models/question"
require_relative "../models/post"
require_relative "../models/user"
require 'date'

# Display all questions.
get "/advice" do
  @posts = Post.all
  @questions = Question.all
  erb :'advice/index'
end

# Create a new question.
get "/advice/new" do
  @users = User.all
  current_time = DateTime.now
  @date = current_time.strftime "%Y/%m/%d"
  erb :"advice/new"
end

# Display a single question and it's responses.
get "/advice/:id" do
  erb :"advice/show"
end

# Post new question.
post "/advice" do
  @params = params
  @Question = Question.create( params )
  redirect to "/advice"
end

# Edit a question.
get "/advice/:id/edit" do
  @question = Question.find( params[ :id ])
  erb :"/advice/edit"
end

# Post edited question.
post "/advice/:id" do
  @question = Question.new( params )
  @question.update
  redirect to "/advice"
end

# Post deleted question.
post "/questions/:id/delete" do
  Question.destroy( params[ :id ])
  redirect to "/advice"
end