class User < ActiveRecord::Base
  enum gender: { 'male' => 1, 'female' => 2 }
  validates :name, :address, presence: true
  validates :phone, presence: true,length: {in: 10..15 }
  validates :password, presence: true, length: { minimum: 8 }
  validates :username, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :gender, inclusion: { in: User.genders.keys } 
  has_many :orders, dependent: :destroy
end
