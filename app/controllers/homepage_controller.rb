class HomepageController < ApplicationController
  def index
  end
  def withdraw 
    @withdrawal = Withdraw.with_convert(params[:amount])
    if @withdrawal
      render json: { withraw_details: @withdrawal }, status: :ok
    else
      render json: { message: "empty" }, status: :bad_request
    end
  end
end
