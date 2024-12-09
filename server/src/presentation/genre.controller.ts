import { Request, Response } from "express";
import GenreService from "../application/genre.service";

class GenreController {
    constructor(private genreService: GenreService) {}

    async getAllGenres(request: Request, response: Response): Promise<void>{

    }

    async getGenreById(request: Request, response: Response): Promise<void>{
        
    }

    async updateGenre(request: Request, response: Response): Promise<void>{
        
    }

    async deleteGenre(request: Request, response: Response): Promise<boolean>{
        return true;
    }
}

export default GenreController;