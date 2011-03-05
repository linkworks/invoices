class InvoicesController < ApplicationController
  # GET /invoices
  # GET /invoices.xml
  def index
    #@invoices = Invoice.all
    @invoices = Invoice.where('client_id in (?)', current_user.company.clients.all.collect(&:id)) \
                       .paginate(:page => params[:page], :per_page => 10, :order => 'created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.xml
  def show
    @invoice = Invoice.where('id = ? and client_id in (?)', params[:id], current_user.company.clients.all.collect(&:id)).first
    
    not_found and return unless @invoice
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
      format.pdf { render :layout => false }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.xml
  def new
    @invoice = Invoice.new
    @item = Item.new # Fix for error list, which throws exception if item is nil

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.where('id = ? and client_id in (?)', params[:id], current_user.company.clients.all.collect(&:id)).first
    not_found and return unless @invoice
  end

  # POST /invoices
  # POST /invoices.xml
  def create
    @invoice = Invoice.new(params[:invoice])
    
    respond_to do |format|
      if @invoice.validate_client_belongs_to(current_user) and @invoice.save
        format.html { redirect_to(@invoice, :notice => t('.invoice_created')) }
        format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.xml
  def update
    @invoice = Invoice.where('id = ? and client_id in (?)', params[:id], current_user.company.clients.all.collect(&:id)).first
    
    not_found and return unless @invoice

    respond_to do |format|
      if @invoice.validate_client_belongs_to(current_user) and @invoice.update_attributes(params[:invoice])
        format.html { redirect_to(@invoice, :notice => t('.invoice_updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.xml
  def destroy
    @invoice = Invoice.where('id = ? and client_id in (?)', params[:id], current_user.company.clients.all.collect(&:id)).first
    not_found and return unless @invoice
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to(invoices_url, :notice => t('.invoice_deleted')) }
      format.xml  { head :ok }
    end
  end
end
