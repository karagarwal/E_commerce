class Order < ActiveRecord::Base
  validates :order_number, numericality: { only_integer: true }, presence: true
	validates_inclusion_of :payment_mode, :in => ["Card","Netbanking","cod"], presence: true
  belongs_to :item
  belongs_to :user
  has_one :invoice
end
