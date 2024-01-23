class PhotosController < ApplicationController
  def destroy
    @flat = Flat.find(params[:flat_id])
    @photo = @flat.photos.where(id = params[:id])
    redirect_to flats_path
  end
end
