import { Router } from "express";
import PlaylistRepository from "../infrastructure/repository/playlist.repository";
import PlaylistService from "../application/playlist.service";
import PlaylistController from "../presentation/playlist.controller";

const playlistRouter = Router();
const playlistRepository = new PlaylistRepository();
const playlistService = new PlaylistService(playlistRepository);
const playlistController = new PlaylistController(playlistService);

playlistRouter.get('/', playlistController.getAllPlaylists)

export default playlistRouter;