class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.xml
  def index
    not_found and return # Disable this view for now
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    not_found and return # Disable this view for now
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    not_found and return # Disable this view for now
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    not_found and return unless params[:id].to_i == current_user.company_id
    
    # Overwrite the company id if it was tampered with
    params[:id] = current_user.company_id
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.xml
  def create
    not_found and return # Disable this view for now
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to(@company, :notice => 'Company was successfully created.') }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    not_found and return unless params[:id].to_i == current_user.company_id
    
    # Overwrite the company id if it was tampered with
    params[:id] = current_user.company_id
    params[:company][:id] = current_user.company_id
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to(edit_company_path(@company), :notice => t('.company_updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    not_found and return # Disable manual company deletion
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end
end
