FactoryGirl.define do
  factory :item do
    name Faker::Commerce.product_name
    price Faker::Commerce.price
    weight Faker::Number.decimal(2)
    brand Faker::Commerce.material
    association :category, factory: :category, strategy: :create
  end
end
