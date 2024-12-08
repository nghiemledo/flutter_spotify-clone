import ArtistRepository from "../infrastructure/repositories/artist.repository";

class ArtistService {
    constructor(private artistRepository: ArtistRepository) {}
}

export default ArtistService;