class SessionsController < ApplicationController
  # GET /login
  def new
  end
  
  # POST /login
  def create
    if @current_user = User.authenticate(params[:email], params[:password])
      session[:user_id] = @current_user.id
      redirect_to users_path, :notice => t('.login_message')
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
    redirect_to show_login_path, :notice => t('.logout_message')
  end

end
