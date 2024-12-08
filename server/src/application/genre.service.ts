import GenreRepository from "../infrastructure/repository/genre.repository";

class GenreService {
    constructor(private genreRepository: GenreRepository) {}
}

export default GenreService;