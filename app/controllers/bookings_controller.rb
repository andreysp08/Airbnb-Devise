class BookingsController < ApplicationController
  def index
    @flat = Flat.find(params[:flat_id])
    @bookings = Booking.all
  end

  def new
    @flat = Flat.find(params[:flat_id])
    # user
    # @user = current_user
    @booking = Booking.new
  end

  def create
    @flat = Flat.find(params[:flat_id])
    # user
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to @booking, notice: "Booking was accepted successfully!!!", status: :see_other
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to flat_path(@booking.flat), status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :status, :user_id, :flat_id)
  end
end
