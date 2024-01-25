class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:autocomplete, :index]
  after_action :verify_authorized, except: :autocomplete, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :autocomplete, unless: :skip_pundit?
  before_action :set_flat, only: %i[show edit update destroy]

  def index
    @flats = policy_scope(Flat)
    authorize @flats

    search = params[:query].present? ? params[:query] : nil
    @flats = if search
      result_search = Flat.search(search).to_a
      search_by_proximity = Flat.near(search, 3000, units: :km).to_a
      result_search += search_by_proximity
      @flats = result_search.uniq
    else
      policy_scope(Flat).all
    end
  end

  def map
    @flats = Flat.all
    authorize @flats
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
    # @flat.photos.each do |photo|
    #   Cloudinary::Uploader.attach(photo.key)
    # end
    @flat.update(flat_params)
    redirect_to flats_path
  end

  def destroy
    @flat.destroy
    redirect_to flats_path, notice: "Flat was successfully destroyed!", status: :see_other
  end

  # def delete_photos_flat
  #   # @article.photo.purge
  #   @photo = Flat.where(phots.id = params[:id])
  #   @photo = Flat.photos.find(params[:id])
  #   @photo.purge
  #   redirect_to flats_path
  # end
  # def delete_image_attachment
  #   @image = ActiveStorage::Blob.find_signed(params[:id])
  #   @image.purge
  #   redirect_to flats_url
  # end

  def delete_an_image
    @flat = Flat.find(delete_an_image_params[:flat_id])
    @image = @flat.photos.find(delete_an_image_params[:attachment_id])
    @image.purge
    redirect_to edit_flat_path(delete_an_image_params[:flat_id])
  end

  def mybookings
    @bookings_visitor = Booking.where(user_id: current_user.id)
    @flats = Flat.where(user_id: current_user.id)
    authorize @flats
    @bookings_owner = Booking.where(flat_id: @flats)
  end

  def autocomplete
    @flats = policy_scope(Flat)
    if params[:query].present?
      result_search = Flat.search(params[:query]).to_a
      search_by_proximity = Flat.near(params[:query], 3000, units: :km).to_a
      result_search += search_by_proximity
      @flats = result_search.uniq
    end
    render json: @flats.map { |flat| { name: flat.name, address: flat.address } }
    # render json: Flat.search(params[:query]).map { |flat| { name: flat.name, address: flat.address } }
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def flat_params
    params.require(:flat).permit(:name, :address, :pricing, :description, :avaliability, photos: [])
  end

  def delete_an_image_params
    params.permit(:authenticity_token, :commit, :_method, :flat_id, :attachment_id)
  end
end
