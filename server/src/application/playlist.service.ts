import PlaylistRepository from "../infrastructure/repositories/playlist.repository";

class PlaylistService {
    constructor(private playlistRepository: PlaylistRepository) {}
}

export default PlaylistService;