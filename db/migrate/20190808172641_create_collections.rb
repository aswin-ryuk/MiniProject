class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.decimal :amount, precision: 38, scale: 1
      t.string :reference
      t.date :collection_date
    end
  end
end
