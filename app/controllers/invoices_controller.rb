class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:show, :edit, :update, :add_collection, :invoice_details]

  def index
    @invoices = Invoice.all.paginate :per_page => PER_PAGE, :page => params[:page]
  end

  def show_collected_bills
    invoices = Invoice.joins('JOIN (select abs(sum(collections.amount)) as collection_amount, collections.reference from  collections group by collections.reference ) collections ON invoices.reference = collections.reference').
               where('(invoices.amount - collection_amount) = 0')
    @invoices = invoices.paginate :per_page => PER_PAGE, :page => params[:page]
    render :index
  end

  def show_pending_bills
    invoices = Invoice.joins('LEFT JOIN collections ON invoices.reference=collections.reference').
                where('collections.reference IS NULL')
    @invoices = invoices.paginate :per_page => PER_PAGE, :page => params[:page]
    render :index
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      flash[:notice] = 'Invoice was successfully created.'
      redirect_to invoices_path
    else
      render :new
    end
  end

  def add_collection    
    @collection = Collection.new(reference: @invoice.reference, collection_date: Date.today)
    render json: {content: render_to_string('invoices/add_collection', locals: {collection: @collection},
          formats: [:html], layout: false ) }
  end

  def save_collection
    @collection = Collection.new(collection_params)
    if @collection.amount.present?
      @collection.amount = -(@collection.amount.abs) 
      collected_total = Collection.where(reference: @collection.reference).sum(:amount).abs 
      invoice_amount = Invoice.where(reference: @collection.reference).first.amount
      @check = ((invoice_amount - collected_total) >= @collection.amount.abs)
      if @check && @collection.save 
        flash[:notice] = 'Collection was successfully added.'
        redirect_to invoices_path
      else
        render :add_collection
      end
    else
      render :add_collection
    end
  end

  def invoice_details
    collections =  Collection.where(reference: @invoice.reference)
    render json: {content: render_to_string('invoices/invoice_details', locals: {invoice: @invoice, collections: collections},
          formats: [:html], layout: false ) }
  end
  
  def update
    if @invoice.update(invoice_params)
      flash[:notice] = 'Invoice was successfully updated.'
      redirect_to invoices_path
    else
      render :edit        
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.where(id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:brand_manager, :narration, :invoice_date, :amount, :customer_name, :reference)
    end

    def collection_params
      params.require(:collection).permit(:amount, :collection_date, :reference)
    end
end
