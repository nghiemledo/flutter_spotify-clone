import ArtistRepository from "../infrastructure/repository/artist.repository";

class ArtistService {
    constructor(private artistRepository: ArtistRepository) {}
}

export default ArtistService;