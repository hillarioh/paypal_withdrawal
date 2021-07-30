class HomepageController < ApplicationController
  skip_before_action :verify_authenticity_token
  after_action :allow_iframe
  APP_KEY = "254qwerty"
  def index
    p cookies[:user_id]
    # data = "eyJET01BSU4iOiJmaW5wbHVzLnNhbmRib3gubWFtYnUuY29tIiwiQUxHT1JJVEhNIjoiaG1hY1NIQTI1NiIsIlRFTkFOVF9JRCI6ImZpbnBsdXMiLCJVU0VSX0tFWSI6IjhhODU4Njk1N2FkY2NhMTEwMTdhZTJjYTY2ZmQwYmY1In0"
    # p Base64.decode64("eyJET01BSU4iOiJmaW5wbHVzLnNhbmRib3gubWFtYnUuY29tIiwiQUxHT1JJVEhNIjoiaG1hY1NIQTI1NiIsIlRFTkFOVF9JRCI6ImZpbnBsdXMiLCJVU0VSX0tFWSI6IjhhODU4Njk1N2FkY2NhMTEwMTdhZTJjYTY2ZmQwYmY1In0")

  end

  def credentials
    data={
        "id": "254qwerty",
        "name": "PayPal Withdrawal",
        "provider": "Finplus group",
        "description": "An app to calculate paypal transaction fee to Client Mpesa",
        "installUrl": "https://tranquil-reef-08552.herokuapp.com/",
        "extensionpoint": {
          "location": "EXTENSION_MENU",
          "label": "PAYPAL Withdrawal",
          "url": "https://tranquil-reef-08552.herokuapp.com/authenticate",
        }
    }   
    
    render :xml =>  data.to_xml(:root => :app, :skip_types => true)      
  end

  def authenticate
    result = params[:signed_request].split(".")
    mac = OpenSSL::HMAC.hexdigest("SHA256", APP_KEY, result[1])    

    @user_info = Base64.decode64(result[1])
    
    # cookies[:user_id] = result
    @user_info = JSON[@user_info.as_json]

    User.create(user_key: @user_info["USER_KEY"], domain: @user_info["DOMAIN"])
    cookies[:user_id] = @user_info["USER_KEY"]

    if mac == result[0]
      redirect_to root_path
    else
      redirect_to not_found_path
    end
  end

  def user_info
    p cookies[:user_id]
    render :json => User.last.as_json
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
    response.headers.delete "X-Frame-Options"
  end
end
