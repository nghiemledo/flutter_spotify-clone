import { Router } from "express";
import ArtistController from "../presentation/artist.controller";
import ArtistService from "../application/artist.service";
import ArtistRepository from "../infrastructure/repositories/artist.repository";

const artistRouter = Router();
const artistRepository = new ArtistRepository();
const artistService = new ArtistService(artistRepository);
const artistController = new ArtistController(artistService);

artistRouter.get("/", artistController.getAllArtists);

export default artistRouter;