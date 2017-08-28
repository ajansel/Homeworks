class AlbumsController < ApplicationController
  # def index
  #   @albums = Album.all
  #   render :index
  # end

  def new
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = "Please enter all fields"
      redirect_to new_album_url
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])

    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = "Please enter all fields"
      redirect_to new_album_url
    end
  end

  def show
    @album = Album.find_by(id: params[:id])

    if @album
      render :show
    else
      flash.now[:errors] = "Album does not exist"
      redirect_to new_album_url
    end
  end

  def album_params
    params.require(:album).permit(:title, :year, :live?, :band_id)
  end
end
