import GenreRepository from "../infrastructure/repositories/genre.repository";

class GenreService {
    constructor(private genreRepository: GenreRepository) {}
}

export default GenreService;