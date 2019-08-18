class ChangeContactNumberToString < ActiveRecord::Migration[5.1]
  def change
  	change_column :students, :contact_number, :string
  end
end
