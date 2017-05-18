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
    all_albums = albums.
      select('albums.*, COUNT(*) AS tracks_count').
      joins(:tracks).
      group('albums.id')

    all_albums.each_with_object({}) do |album, album_count|
      album_count[album.title] = album.tracks_count
    end
  end
end
