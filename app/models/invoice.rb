class Invoice < ActiveRecord::Base
	validates :invoice_number, numericality: { only_integer: true }, presence: true
  validates :amount, numericality: { only_decimal: true }, presence: true
  belongs_to :order
end
