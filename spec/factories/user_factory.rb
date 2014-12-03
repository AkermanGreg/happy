#NOTE: Factory Girl Expects that each class inherits from ActiveRecord
FactoryGirl.define do
  factory :user, class: User do

    username "Example User" 
    email "user@example.com"
    password "foobar"
    password_confirmation "foobar"
    id "3"


  end


  


end