class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.decimal :weight
      t.string :brand
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
