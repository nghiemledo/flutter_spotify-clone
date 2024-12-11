import PlaylistRepository from "../infrastructure/repositories/playlist.repository";
import PlaylistVM from "../infrastructure/viewmodel/playlist.vm";

class PlaylistService {
    constructor(private playlistRepository: PlaylistRepository) {}

    async getAllPlaylist(): Promise<PlaylistVM[]> {
        return this.playlistRepository.findAll();
    }
    
    async createPlaylist(playlist: PlaylistVM) {
        return this.playlistRepository.create(playlist);
    }

    async getPlaylistById(id: string) {
        return this.playlistRepository.findById(id);
    }

    async updatePlaylist(id: string, playlist: PlaylistVM) {
        return this.playlistRepository.update(id, playlist);
    }
    async deletePlaylist(id: string) {
        return this.playlistRepository.delete(id);
    }
}

export default PlaylistService;