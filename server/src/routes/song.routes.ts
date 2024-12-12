import { Router } from "express";
import SongRepository from "../infrastructure/repositories/song.repository";
import SongService from "../application/song.service";
import SongController from "../presentation/song.controller";

const songRouter = Router();
const songRepository = new SongRepository();
const songService = new SongService(songRepository);
const songController = new SongController(songService);

songRouter.get('/', songController.getAllSongs.bind(songController));
songRouter.get('/:songId', songController.getSongById.bind(songController));
songRouter.post("/upload", songController.uploadSong.bind(songController));
songRouter.get("/stream/:songId", songController.streamSong.bind(songController));
songRouter.delete('/:id', songController.deleteSong.bind(songController));

export default songRouter;