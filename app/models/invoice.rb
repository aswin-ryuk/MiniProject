class Invoice < ApplicationRecord
	
	validates :brand_manager, :narration, :invoice_date, :amount, :customer_name, :reference, presence: true

	validates :reference, uniqueness: { case_sensitive: false }
end
