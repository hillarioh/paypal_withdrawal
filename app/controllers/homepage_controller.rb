class HomepageController < ApplicationController
  skip_before_action :verify_authenticity_token
  after_action :allow_iframe
  
  def index
  end

  def credentials
    data={
        "id": "254qwerty",
        "name": "TRIALS TU",
        "provider": "Finplus group",
        "description": "An app to calculate paypal transaction fee to Client Mpesa",
        "installUrl": "https://330b8cddc71d.ngrok.io/",
        "extensionpoint": {
          "location": "EXTENSION_MENU",
          "label": "TRIALS TWO",
          "url": "https://330b8cddc71d.ngrok.io/authenticate",
        }
    }   
    
    render :xml =>  data.to_xml(:root => :app, :skip_types => true)      
  end

  def authenticate
    token = params[:signed_request]
    User.set_token(token)
    redirect_to root_path
  end

  def user_info 
    render json: {user_info: User.user_details} , status: :ok
  end

  def withdraw 
    @ksh_withdrawal = Withdraw.without_conversion(params[:amount])
    @usd_withdrawal = Withdraw.with_conversion(params[:amount])
    if @ksh_withdrawal && @usd_withdrawal
      render json: {ksh: @ksh_withdrawal,usd: @usd_withdrawal} , status: :ok
    else
      render json: { message: "empty" }, status: :bad_request
    end
  end

  def unauthorized    
  end

  private
  def allow_iframe
    # cookies[:user_id] = 34
    response.headers.delete "X-Frame-Options"
  end
end
