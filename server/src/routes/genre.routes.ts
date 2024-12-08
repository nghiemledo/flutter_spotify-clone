import { Router } from "express";
import GenreController from "../presentation/genre.controller";
import GenreService from "../application/genre.service";
import GenreRepository from "../infrastructure/repository/genre.repository";

const genreRouter = Router();
const genreRepository = new GenreRepository();
const genreService = new GenreService(genreRepository);
const genreController = new GenreController(genreService);

genreRouter.get('/', genreController.getAllGenres);

export default genreRouter;