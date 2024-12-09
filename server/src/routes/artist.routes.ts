import { Router } from "express";
import ArtistController from "../presentation/artist.controller";
import ArtistService from "../application/artist.service";
import ArtistRepository from "../infrastructure/repositories/artist.repository";

const artistRouter = Router();
const artistRepository = new ArtistRepository();
const artistService = new ArtistService(artistRepository);
const artistController = new ArtistController(artistService);

artistRouter.get("/", artistController.getAllArtists.bind(artistController));
artistRouter.post("/", artistController.createArtist.bind(artistController));
artistRouter.get("/:id", artistController.getArtistById.bind(artistController));
artistRouter.put("/:id", artistController.updateArtist.bind(artistController));
artistRouter.delete("/:id", artistController.deleteArtist.bind(artistController));

export default artistRouter;