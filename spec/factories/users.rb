FactoryGirl.define do
  factory :user do
  	name 'Praveen'
  	sequence(:email) {|n| "email#{n}@gmail.com"} 
  	password 'pw'   
  end

end
