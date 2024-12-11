import SongRepository from "../infrastructure/repositories/song.repository";
import SongVM from "../infrastructure/viewmodel/song.vm";

class SongService {
    constructor(private songRepository: SongRepository) {}

    async getAllSongs(): Promise<SongVM[]> {
        return this.songRepository.findAll();
    }
    
    async getSongById(id: string): Promise<SongVM | null> {
        return this.songRepository.findById(id);
    }

    async createSong(song:SongVM): Promise<SongVM>{
        return this.songRepository.create(song);
    }

    async updateSong(id: string, song: SongVM): Promise<SongVM | null>{
        return this.songRepository.update(id, song);
    }

    async deleteSong(id: string): Promise<boolean> {
        return this.songRepository.delete(id);
    }
}

export default SongService;