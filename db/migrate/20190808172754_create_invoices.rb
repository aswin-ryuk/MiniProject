class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.string :brand_manager
      t.string :narration
      t.date :invoice_date
      t.decimal :amount, precision: 38, scale: 1
      t.string :customer_name
      t.string :reference
    end
  end
end
