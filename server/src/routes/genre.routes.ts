import { Router } from "express";
import GenreController from "../presentation/genre.controller";
import GenreService from "../application/genre.service";
import GenreRepository from "../infrastructure/repositories/genre.repository";

const genreRouter = Router();
const genreRepository = new GenreRepository();
const genreService = new GenreService(genreRepository);
const genreController = new GenreController(genreService);

genreRouter.get('/', genreController.getAllGenres.bind(genreController));
genreRouter.post('/', genreController.createGenre.bind(genreController));
genreRouter.get('/:id', genreController.getGenreById.bind(genreController));
genreRouter.put('/:id', genreController.updateGenre.bind(genreController));
genreRouter.delete('/:id', genreController.deleteGenre.bind(genreController));

export default genreRouter;