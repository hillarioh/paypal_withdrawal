class HomepageController < ApplicationController
  def index
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
