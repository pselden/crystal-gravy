module PlaylistsHelper
  def playlist_url(name, id)
    "/playlists/#{name.gsub(/ /,'_')}-#{id.to_s}"
  end
end
