class Item < ActiveRecord::Base
  validates :name, :brand, presence: true
  validates :price, :weight, numericality: { only_decimal: true }, presence: true
  belongs_to :category
  has_many :orders, dependent: :destroy
end
