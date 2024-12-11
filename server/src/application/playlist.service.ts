import PlaylistRepository from "../infrastructure/repositories/playlist.repository";
import PlaylistVM from "../infrastructure/viewmodel/playlist.vm";

class PlaylistService {
    constructor(private playlistRepository: PlaylistRepository) {}

    async getAllPlaylist(): Promise<PlaylistVM[]> {
        return this.playlistRepository.findAll();
    }
    
    async createPlaylist(playlist: PlaylistVM): Promise<PlaylistVM> {
        return this.playlistRepository.create(playlist);
    }

    async getPlaylistById(id: string): Promise<PlaylistVM | null> {
        return this.playlistRepository.findById(id);
    }

    async updatePlaylist(id: string, playlist: PlaylistVM): Promise<PlaylistVM | null> {
        return this.playlistRepository.update(id, playlist);
    }

    async deletePlaylist(id: string): Promise<boolean> {
        return this.playlistRepository.delete(id);
    }
}

export default PlaylistService;