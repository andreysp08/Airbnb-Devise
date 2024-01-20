class BookingsController < ApplicationController
  before_action :set_flat, only: %i[index new create]
  # def index
  #   @bookings = policy_scope(Booking.where(flat: @flat))
  #   authorize @bookings
  # end

  def new
    @booking = Booking.new(flat: @flat, user: current_user)
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking

    if @booking.save
      redirect_to flat_path(@booking.flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking

    if @booking.update(booking_params)
      redirect_to @booking, notice: "Booking was accepted or declined successfully!!!", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking

    @booking.destroy
    redirect_to flat_path(@booking.flat), status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :status, :user_id, :flat_id)
  end

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end
end
