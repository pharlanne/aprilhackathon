require_relative "../models/account"

Transaction.delete_all
Merchant.delete_all
Tag.delete_all
Income.delete_all
Target.delete_all
Post.delete_all
Question.delete_all
User.delete_all

merchant1 = Merchant.create( "name" => "Tesco" )
merchant2 = Merchant.create( "name" => "Scottish Power" )
merchant3 = Merchant.create( "name" => "Amazon" )
merchant4 = Merchant.create( "name"=> "Edinburgh City Council" )
merchant5 = Merchant.create( "name" => "Dominos Pizza" )
merchant6 = Merchant.create( "name" => "CodeClan" )
merchant7 = Merchant.create( "name" => "Waitrose" )
merchant8 = Merchant.create( "name" => "Real Foods" )
merchant9 = Merchant.create( "name" => "Sainsburys" )
merchant10 = Merchant.create( "name" => "Costa Coffee" )
merchant11 = Merchant.create( "name" => "Boots" )
merchant12 = Merchant.create( "name" => "National Line" )

tag1 = Tag.create( "name" => "Groceries", "monthly_budget" => 250.00 )
tag2 = Tag.create( "name" => "Utilities", "monthly_budget" => 750.00 )
tag3 = Tag.create( "name" => "Travel", "monthly_budget" => 100.00 )
tag4 = Tag.create( "name" => "Business", "monthly_budget" => 50.00 )
tag5 = Tag.create( "name" => "Education", "monthly_budget" => 1000.00 )
tag6 = Tag.create( "name" => "Childcare", "monthly_budget" => 500.00 )
tag7 = Tag.create( "name" => "Gift", "monthly_budget" => 0.00 )
tag8 = Tag.create( "name" => "Clothing", "monthly_budget" => 100.00 )
tag9 = Tag.create( "name" => "Cosmetics", "monthly_budget" => 35.00 )
tag10 = Tag.create( "name" => "Insurance", "monthly_budget" => 150.00 )

transaction1 = Transaction.create(
  "amount" => 103.27,
  "transaction_date" => "1-April-16",
  "merchant_id" => merchant1.id,
  "tag_id" => tag1.id
  )

transaction2 = Transaction.create(
  "amount" => 75.50,
  "transaction_date" => "2-April-16",
  "merchant_id" => merchant2.id,
  "tag_id" => tag2.id
  )

transaction3 = Transaction.create(
  "amount" => 450.00,
  "transaction_date" => "1-April-16",
  "merchant_id" => merchant3.id,
  "tag_id" => tag2.id
  )

transaction4 = Transaction.create(
  "amount" => 62.50,
  "transaction_date" => "2-April-16",
  "merchant_id" => merchant4.id,
  "tag_id" => tag2.id
  )

transaction5 = Transaction.create(
  "amount" => 1500,
  "transaction_date" => "14-February-16",
  "merchant_id" => merchant6.id,
  "tag_id" => tag5.id
  )

transaction6 = Transaction.create(
  "amount" => 24.99,
  "transaction_date" => "11-April-16",
  "merchant_id" => merchant1.id,
  "tag_id" => tag1.id
  )

transaction7 = Transaction.create(
  "amount" => 18.51,
  "transaction_date" => "7-April-16",
  "merchant_id" => merchant1.id,
  "tag_id" => tag1.id
  )

transaction8 = Transaction.create(
 "amount" => 156,
 "transaction_date" => "11-April-16",
 "merchant_id" => merchant6.id,
 "tag_id" => tag5.id
 )

transaction9 = Transaction.create(
  "amount" => 26.91,
  "transaction_date" => "28-March-16",
  "merchant_id" => merchant7.id,
  "tag_id" => tag1.id
  )

transaction10 = Transaction.create(
  "amount" => 41.60,
  "transaction_date" => "22-March-16",
  "merchant_id" => merchant1.id,
  "tag_id" => tag1.id
  )

transaction11 = Transaction.create(
  "amount" => 4.28,
  "transaction_date" => "23-March-16",
  "merchant_id" => merchant8.id,
  "tag_id" => tag1.id
  )

transaction12 = Transaction.create(
  "amount" => 4.28,
  "transaction_date" => "17-April-16",
  "merchant_id" => merchant8.id,
  "tag_id" => tag1.id
  )

transaction13 = Transaction.create(
  "amount" => 22.50,
  "transaction_date" => "19-April-16",
  "merchant_id" => merchant5.id,
  "tag_id" => tag4.id
  )

transaction14 = Transaction.create(
  "amount" => 22.50,
  "transaction_date" => "4-April-16",
  "merchant_id" => merchant5.id,
  "tag_id" => tag4.id
  )

transaction15 = Transaction.create(
  "amount" => 22.50,
  "transaction_date" => "12-February-16",
  "merchant_id" => merchant5.id,
  "tag_id" => tag4.id
  )

income1 = Income.create(
  "amount" => 2500,
  "income_date" => "1-February-16"
  )

income2 = Income.create(
  "amount" => 2500,
  "income_date" => "1-March-16"
  )

income3 = Income.create(
  "amount" => 2500,
  "income_date" => "1-April-16"
  )

target1 = Target.create(
  "name" => "Jarrods Birthday Present",
  "amount" => 500,
  "target_date" => "11-May-16",
  "image_url" => ""
  )

user1 = User.create(
  "username" => "Anne",
  "reputation" => 1,
  "avatar" => ""
  )

user2 = User.create(
  "username" => "Peter",
  "reputation" => 2,
  "avatar" => ""  
  )

puts user1.id

# questions

question1 = Question.create(
  "title" => "What is the best 0% APR credit card?",
  "question_date" => "1-April-16",
  "user_id" => user1.id
  )

question2 = Question.create(
  "title" => "Test question",
  "question_date" => "29-March-16",
  "user_id" => user1.id
  )

question3 = Question.create(
  "title" => "If I had £1000 should I start an ISA",
  "question_date" => "29-March-16",
  "user_id" => user1.id
  )

question4 = Question.create(
  "title" => "Where should I start a pension?",
  "question_date" => "29-March-16",
  "user_id" => user1.id
  )

# posts

post_params = {
  "question_id" => question1.id,
  "user_id" => user2.id,
  "response" => 'This is a great question',
  "post_date" => "29-March-16"
}

post1 = Post.create(post_params)

post_params = {
  "question_id" => question1.id,
  "user_id" => user1.id,
  "response" => 'Thanks for the response, I am now rich.',
  "post_date" => "29-March-16"
}

post2 = Post.create(post_params)

post_params = {
  "question_id" => question1.id,
  "user_id" => user2.id,
  "response" => 'Its ok, Im Bill Gates',
  "post_date" => "29-March-16"
}

post3 = Post.create(post_params)