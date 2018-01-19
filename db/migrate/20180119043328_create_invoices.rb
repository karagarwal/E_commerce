class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :invoice_number
      t.integer :amount
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end
