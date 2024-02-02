class PhotosController < ApplicationController
  def destroy
    @flat = Flat.find(params[:flat_id])
    @photo = @flat.photos.find_by(id: params[:id])
    @photo.purge
    # @flat.update
    # authorize @photo
    redirect_to edit_flat_path(@flat)

  end
end
