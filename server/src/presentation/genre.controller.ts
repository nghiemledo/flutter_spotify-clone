import { Request, Response } from "express";
import GenreService from "../application/genre.service";
import ValidationError from "../errors/validation.error";
import GenreEntity from "../domain/entities/genre.entity";
import GenreVM from "../infrastructure/viewmodel/genre.vm";

class GenreController {
    constructor(private genreService: GenreService) {}

    async getAllGenres(request: Request, response: Response): Promise<void>{
        try {
            const genres = await this.genreService.getAllGenres();
            if(!genres) {
               throw new ValidationError("Can not get genre data", "genres");
            } 
            response.status(200).json({
                message: "Get all genres successfully",
                data: genres
            });
        } catch(error: any) {
            response.status(500).json({message: error.message})
        }
    }

    async getGenreById(request: Request, response: Response): Promise<void>{
        try {
            const { id } = request.params;
            const genre = await this.genreService.getGenreById(id);
            if(!genre) {
                throw new ValidationError("Genre not found", "genre");
            } 
            response.status(200).json({
                message: "Get genre successfully",
                data: genre
            })
        } catch (error: any) {
            response.status(500).json({message: error.message})
        }
    }

    async createGenre(request: Request, response: Response): Promise<void>{
        try {
            const {name, description} = request.body;
            const existedGenre = await GenreEntity.findOne({name});
            if(existedGenre) {
                 response.status(400).json("Genre is already exist");
                 return;
            }

            const newGenre = new GenreVM(name, description);
            const result = await this.genreService.createGenre(newGenre);

            if(!result) {
                response.status(400).json("Failed to create successfully");
                return;
            }
            response.status(201).json({
                message: "Create genre successfully",
                data: result
            })
        } catch (error: any) {
            response.status(500).json({message: "Internal server error"})
        }
    }

    async updateGenre(request: Request, response: Response): Promise<void>{
        try {
            const {id} = request.params;
            const {name, description} = request.body;
            const existingGenre = await this.genreService.getGenreById(id);
            if(!existingGenre) {
                throw new ValidationError("Genre not found", "artist");
            }
            const isSameGenre = existingGenre.description == name 
            && existingGenre.description == description
            if(isSameGenre) {
                response.status(400).json("No change detected");
                return;
            } else {
                const updatedGenre = new GenreVM(name, description);
                const genre = await this.genreService.updateGenre(id, updatedGenre);
                response.status(200).json({
                    message: "Updated genre successfully",
                    data: genre
                })
            }
        } catch (error: any) {
            response.status(500).json({message: error.message});
        }
    }

    async deleteGenre(request: Request, response: Response): Promise<void>{
        try {
            const { id } = request.params;
            const result = await this.genreService.deleteGenre(id);
            if(!result) {
                throw new ValidationError("Failed to delete genre", "genre")
            } 
            response.status(200).json({
                message: "Delete genre successfully"
            })
        } catch (error: any) {
            response.status(500).json({message: error.message})
        }
    }
}

export default GenreController;