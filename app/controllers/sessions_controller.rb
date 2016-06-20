class SessionsController < ApplicationController

      #error message  
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		#log user in
  		log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_back_or user
  	else
	  	#error message	
	  	flash.now[:danger] = "Invalid password combination!"
	  	render 'new'
  	end
 	end

 	def destroy
    log_out if logged_in?
    redirect_to root_url
 	end

end
