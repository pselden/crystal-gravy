module PlaylistsHelper
  def playlist_url(name, id)
    "/playlists/#{name.gsub(/ /,'_')}-#{id.to_s}"
  end

  def id_from_url(params_url)
    params_url.split("-")[-1]
  end
end
