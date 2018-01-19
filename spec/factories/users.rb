FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    address Faker::Address.city 
    phone Faker::PhoneNumber.cell_phone 
    gender 'male'
    username Faker::Internet.email
    password Faker::Internet.password(8)
  end
end
