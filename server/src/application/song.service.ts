import SongRepository from "../infrastructure/repository/song.repository";

class SongService {
    constructor(private songRepository: SongRepository) {}
}

export default SongService;