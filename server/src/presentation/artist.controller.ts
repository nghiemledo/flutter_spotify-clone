import { Request,Response } from "express";
import ArtistService from "../application/artist.service";

class ArtistController {
    constructor(private artistSerice: ArtistService) {}

    async getAllArtists(request: Request, response: Response): Promise<void> {

    }
}

export default ArtistController;