class ReviewsController < ApplicationController
  def index
    # if this def dont exist the authorization system failed
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @review = Review.new(flat: @flat, user: current_user)
    authorize @review
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @review = Review.new(review_params)
    @review.flat = @flat
    @review.user = current_user
    authorize @review

    if @review.save
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :user_id, :flat_id)
  end
end
