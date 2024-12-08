import { Request, Response } from "express";
import PlaylistService from "../application/playlist.service";

class PlaylistController {
    constructor(private playlistService: PlaylistService) {}

    async getAllPlaylists(request: Request, response: Response): Promise<void> {

    }
}

export default PlaylistController;