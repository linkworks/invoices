class UsersController < ApplicationController
  skip_before_filter :authorize, :only => [:sign_up, :public_create]
  before_filter :require_admin, :except => [:sign_up, :public_create]
  before_filter :require_signed_out, :only => [:sign_up, :public_create]
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    if Company.all.empty?
      redirect_to new_company_path
    else
      @user = User.new
      
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @user }
      end
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /sign_up
  def sign_up
    @user = User.new
    @company = Company.new
  end
  
  # POST /sign_up
  def public_create
    @company = Company.new({:name => params[:company_name], :address => params[:company_address]})
    @user = User.new({
      :email => params[:email],
      :password => params[:password],
      :password_confirmation => params[:password_confirmation],
      :user_type => 'user' # Important that this is user
    })
    
    User.transaction do
      @user.save!
      @company.save!
      
      @user.company_id = @company.id
      @user.save!
    end
    
    respond_to do |format|
      format.html { redirect_to show_login_path, :notice => t('.sign_up_success') }
    end
    
  rescue ActiveRecord::RecordInvalid => invalid # Meaning something was not filled correctly in form
    respond_to do |format|
      format.html { render :action => :sign_up }
    end
  end
end
