import ArtistRepository from "../infrastructure/repositories/artist.repository";
import ArtistVM from "../infrastructure/viewmodel/artist.vm";

class ArtistService {
    constructor(private artistRepository: ArtistRepository) {}

    async getAllArtists(): Promise<ArtistVM[]> {
        return this.artistRepository.findAll();
    }

    async getArtistById(id: string): Promise<ArtistVM | null> {
        return this.artistRepository.findById(id);
    }

    async createArtist(artist: ArtistVM): Promise<ArtistVM> {
        console.log("Service: " + artist);
        
        return this.artistRepository.create(artist);
    }

    async updateArtist(id: string, artist: ArtistVM): Promise<ArtistVM | null> {
        return this.artistRepository.update(id, artist);
    } 

    async deleteArtist(id: string): Promise<boolean> {
        return this.artistRepository.delete(id);
    }
}

export default ArtistService;