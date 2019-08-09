module InvoicesHelper
   def invoices_list_columns
    [
      {label: t('invoice.reference')},
      {label: t('invoice.invoice_date')},
      {label: t('invoice.customer_name')},
      {label: t('invoice.brand_manager')},
      {label: t('invoice.narration')},
      {label: t('invoice.amount')},
      {label: t('invoice.total_collection')},
      {label: t('invoice.balance_due')},
      {label: t('invoice.add_collection')},
    ]
  end

  def total_collection(invoice)
  	Collection.where(reference: invoice.reference).sum(:amount).abs
  end

  def balance_due(invoice)
  	invoice.amount - Collection.where(reference: invoice.reference).sum(:amount).abs
  end

  def is_valid_invoice?
    params[:action] == "show_collected_bills" ? "disabled" : ''  
  end

end