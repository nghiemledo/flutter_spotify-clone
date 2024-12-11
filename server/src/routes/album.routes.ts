import { Router } from "express";
import AlbumRepository from "../infrastructure/repositories/album.repository";
import AlbumService from "../application/album.service";
import AlbumController from "../presentation/album.controller";

const albumRouter = Router();
const repo = new AlbumRepository();
const service = new AlbumService(repo);
const controller = new AlbumController(service);

albumRouter.get("/", controller.getAllAlbums.bind(controller));
albumRouter.post("/", controller.createAlbum.bind(controller));
albumRouter.get("/:id", controller.getAlbumById.bind(controller));
albumRouter.put("/:id", controller.updateAlbum.bind(controller));
albumRouter.delete("/:id", controller.deleteAlbum.bind(controller));

export default albumRouter;