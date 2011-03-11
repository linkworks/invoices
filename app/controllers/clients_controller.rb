class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.xml
  def index
    @clients = current_user.company.clients.paginate(:page => params[:page], :per_page => 10, :order => 'name desc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.xml
  def show
    not_found and return
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.xml
  def create
    params[:client][:company_id] = current_user.company.id # This will overwrite the client_id sent in the hidden field
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to(clients_path, :notice => t('.client_updated')) }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    params[:client][:company_id] = current_user.company.id # This will overwrite the client_id sent in the hidden field
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to(clients_path, :notice => t('.client_updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_url, :notice => t('.client_deleted')) }
      format.xml  { head :ok }
    end
  end
end
