import { Router } from "express";
import SongRepository from "../infrastructure/repositories/song.repository";
import SongService from "../application/song.service";
import SongController from "../presentation/song.controller";

const songRouter = Router();
const songRepository = new SongRepository();
const songService = new SongService(songRepository);
const songController = new SongController(songService);

songRouter.get('/', songController.getAllSongs);
// songRouter.post("/upload", uploadSong, songController.createSong);
// songRouter.get("/stream/:songId", songController.streamSong);

export default songRouter;