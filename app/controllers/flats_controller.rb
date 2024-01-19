class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  # skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_flat, only: %i[show edit update destroy]

  def index
    @flats = policy_scope(Flat)
    @query = params[:query]
    @flats = Flat.global_search(@query) unless @query.nil?
    # @flats = Flat.search(@query) unless @query.nil?
  end

  def map
    @flats = Flat.all
    authorize @flats
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
    authorize @flat
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    authorize @flat

    if @flat.save
      redirect_to flats_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(@flat.user_id)
    @marker = {
      lat: @flat.latitude,
      lng: @flat.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { flat: @flat })
    }
  end

  def edit
    @flat.user = current_user
  end

  def update
    @flat.update(flat_params)
    redirect_to flats_path
  end

  def destroy
    @flat.destroy
    redirect_to flats_path, notice: "Flat was successfully destroyed!", status: :see_other
  end

  def mybookings
    @bookings_visitor = Booking.where(user_id: current_user.id)
    @flats = Flat.where(user_id: current_user.id)
    @bookings_owner = Booking.where(flat_id: @flats)
  end

  def autocomplete
    render json: Flat.search(params[:query], autocomplete: true, limit: 10).map(&:name)
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def flat_params
    params.require(:flat).permit(:name, :address, :pricing, :description, :avaliability, photos: [])
  end
end
