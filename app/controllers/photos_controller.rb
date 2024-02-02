class PhotosController < ApplicationController
  def destroy
    @flat = Flat.find(params[:flat_id])
    @photo = @flat.photos.find_by(id: params[:id])
    authorize @photo, policy_class: PhotoPolicy
    @photo.purge
    redirect_to edit_flat_path(@flat)
  end
end
