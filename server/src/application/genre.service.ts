import GenreRepository from "../infrastructure/repositories/genre.repository";
import GenreVM from "../infrastructure/viewmodel/genre.vm";

class GenreService {
    constructor(private genreRepository: GenreRepository) {}

    async getAllGenres(): Promise<GenreVM[]> {
        return this.genreRepository.findAll();
    }

    async getGenreById(id: string): Promise<GenreVM | null> {
        return this.genreRepository.findById(id);
    }

    async createGenre(genre: GenreVM): Promise<GenreVM> {
        return this.genreRepository.create(genre);
    }

    async updateGenre(id: string, genre: GenreVM): Promise<GenreVM | null> {
        return this.genreRepository.update(id, genre);
    } 

    async deleteGenre(id: string): Promise<boolean> {
        return this.genreRepository.delete(id);
    }
}

export default GenreService;