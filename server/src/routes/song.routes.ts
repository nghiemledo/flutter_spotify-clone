import { Router } from "express";
import SongRepository from "../infrastructure/repository/song.repository";
import SongService from "../application/song.service";
import SongController from "../presentation/song.controller";

const songRouter = Router();
const songRepository = new SongRepository();
const songService = new SongService(songRepository);
const songController = new SongController(songService);

songRouter.get('/', songController.getAllSongs);

export default songRouter;