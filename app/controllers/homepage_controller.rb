class HomepageController < ApplicationController
  skip_before_action :verify_authenticity_token
  APP_KEY = "254qwerty"
  def index
    # data = "eyJET01BSU4iOiJmaW5wbHVzLnNhbmRib3gubWFtYnUuY29tIiwiQUxHT1JJVEhNIjoiaG1hY1NIQTI1NiIsIlRFTkFOVF9JRCI6ImZpbnBsdXMiLCJVU0VSX0tFWSI6IjhhODU4Njk1N2FkY2NhMTEwMTdhZTJjYTY2ZmQwYmY1In0"
    # p Base64.decode64("eyJET01BSU4iOiJmaW5wbHVzLnNhbmRib3gubWFtYnUuY29tIiwiQUxHT1JJVEhNIjoiaG1hY1NIQTI1NiIsIlRFTkFOVF9JRCI6ImZpbnBsdXMiLCJVU0VSX0tFWSI6IjhhODU4Njk1N2FkY2NhMTEwMTdhZTJjYTY2ZmQwYmY1In0")

  end
  def credentials
    data={
        "id": "254qwerty",
        "name": "PayPal Withdrawal",
        "provider": "Finplus group",
        "description": "An app to calculate paypal transaction fee to Client Mpesa",
        "extensionpoint": {
          "location": "EXTENSION_MENU",
          "label": "PAYPAL Withdrawal",
          "url": "https://3e33069cb235.ngrok.io/authenticate",
        }
    }
     render :xml =>  data.to_xml(:root => :app, :skip_types => true)      
  end
  def authenticate
    result = params[:signed_request].split(".")
    mac = OpenSSL::HMAC.hexdigest("SHA256", APP_KEY, result[1])

    if mac == result[0]
      redirect_to root_path
    else
      redirect_to root_path
    end

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
end
