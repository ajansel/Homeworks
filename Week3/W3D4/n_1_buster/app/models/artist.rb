class Artist < ActiveRecord::Base
  has_many(
    :albums,
    class_name: "Album",
    foreign_key: :artist_id,
    primary_key: :id
  )

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # TODO: your code here
    #This will still require us to iterate through tracks
    # albums = self.albums.includes(:tracks)
    #Instead, if we do this first we can use an alias that stores the tracks_count
    albums = self
      .albums
      .select("albums.*, COUNT(*) as tracks_count")
      .joins(:tracks)
      .group("albums.id")


    albums_track_count = {}
    albums.each do |album|
      albums_track_count[album.title] = album.tracks_count
    end

    albums_track_count
  end
end
