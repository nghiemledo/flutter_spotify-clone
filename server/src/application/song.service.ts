import SongRepository from "../infrastructure/repositories/song.repository";
import SongVM from "../infrastructure/viewmodel/song.vm";

class SongService {
    constructor(private songRepository: SongRepository) {}

    async createSong(song:SongVM): Promise<SongVM>{
        return this.songRepository.create(song);
    }
}

export default SongService;