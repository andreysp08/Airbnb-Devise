class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @flats = Flat.all
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
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :address, :pricing, :description, :user_id)
  end
end
