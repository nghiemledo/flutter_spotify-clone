import PlaylistRepository from "../infrastructure/repository/playlist.repository";

class PlaylistService {
    constructor(private playlistRepository: PlaylistRepository) {}
}

export default PlaylistService;