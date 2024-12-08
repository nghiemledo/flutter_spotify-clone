import { Request, Response } from "express";
import GenreService from "../application/genre.service";

class GenreController {
    constructor(private genreService: GenreService) {}

    async getAllGenres(request: Request, response: Response): Promise<void>{

    }
}

export default GenreController;