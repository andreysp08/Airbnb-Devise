class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @flats = Flat.all
    @query = params[:query]
    @flats = Flat.global_search(@query) if !@query.nil?
  end


  def map
    @flats = Flat.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { flat: flat })
      }
    end
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)

    if @flat.save
      redirect_to flats_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @flat = Flat.find(params[:id])
    @user = User.find(@flat.user_id)
    @marker = {
      lat: @flat.latitude,
      lng: @flat.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { flat: @flat })
     }
  end

  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy
    redirect_to flats_path, notice: "Flat was successfully destroyed!", status: :see_other
  end

  def mybookings
    @bookings_visitor = Booking.where(user_id: current_user.id)
    @flats = Flat.where(user_id: current_user.id)
    @bookings_owner = Booking.where(flat_id: @flats)
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :address, :pricing, :description, :avaliability, :user_id, photos: [])
  end
end
