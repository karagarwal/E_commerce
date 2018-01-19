FactoryGirl.define do
  factory :invoice do
    invoice_number Faker::Number.number(5)
    amount Faker::Number.number(5)
    association :order, factory: :order, strategy: :create
  end
end
