class Invoice < ApplicationRecord
	
	validates :brand_manager, :narration, :invoice_date, :amount, :customer_name, :reference, presence: true

end
