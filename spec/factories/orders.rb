FactoryGirl.define do
  factory :order do
    order_number Faker::Number.number(5)
    payment_mode "Card"
    association :user, factory: :user, strategy: :create
    association :item, factory: :item, strategy: :create
  end
end
