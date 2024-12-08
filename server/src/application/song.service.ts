import SongRepository from "../infrastructure/repositories/song.repository";

class SongService {
    constructor(private songRepository: SongRepository) {}
}

export default SongService;