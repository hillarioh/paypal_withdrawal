class HomepageController < ApplicationController
  def index
  end
  def credentials
    data={
      "app": {
        "id": "254qwerty",
        "name": "PayPal Withdrawal",
        "provider": "Finplus group",
        "description": "A tool to export your data in an xbrl report ready to use for mix market",
        "uninstallUrl": "https://mixmarketapp.appspot.com/mambuxbrl/uninstall",
        "installUrl": "httsp://mixmarketapp.appspot.com/mambuxbrl/install",
        "extensionpoint": {
          "location": "REPORTING_VIEW",
          "label": "PAYPAL Withdrawal",
          "url": "https://a06cf2f6381d.ngrok.io",
        }
      }
    }
     render :xml =>  data      
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
