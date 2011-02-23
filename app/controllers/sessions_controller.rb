class SessionsController < ApplicationController
  skip_before_filter :authorize, :except => :destroy
  
  # GET /login
  def new
    redirect_to invoices_path if signed_in?
  end
  
  # POST /login
  def create
    if @current_user = User.authenticate(params[:email], params[:password])
      # Remember him?
      if params[:remember_me]
        # Signed cookies to avoid tampering
        cookies.signed[:remember_id] = { :value => @current_user.id, :expires => 2.weeks.from_now }
        cookies.signed[:remember_key] = { :value => @current_user.remember_key, :expires => 2.weeks.from_now }
      end
      
      session[:user_id] = @current_user.id
      redirect_to invoices_path, :notice => t('.login_message')
    else
      @login_error = true
      respond_to do |format|
        format.html { render :action => :new }
      end
    end
  end
  
  # DELETE /logout
  def destroy
    session[:user_id] = nil
    
    # Delete cookies just in case
    cookies.delete :remember_id
    cookies.delete :remember_key
    
    redirect_to show_login_path, :notice => t('.logout_message')
  end

end
