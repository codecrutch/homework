class CatRentalRequestsController < ApplicationController

  def new
    @cats = Cat.all
    @cat_request = CatRentalRequest.new
    render :new
  end

  def create
    request = CatRentalRequest.new(cat_request_params)

    if request.save
      redirect_to cat_url(request.cat)
    else
      render json: request.errors.full_messages, status: 422
    end
  end

  def approve
    request = CatRentalRequest.find(params[:id])
    request.approve!
    redirect_to cat_url(request.cat)
  end

  def deny
    request = CatRentalRequest.find(params[:id])
    request.deny!
    redirect_to cat_url(request.cat)
  end

  private

  def cat_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
