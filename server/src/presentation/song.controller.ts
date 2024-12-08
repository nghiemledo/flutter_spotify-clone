import { Request, Response } from "express";
import SongService from "../application/song.service";

class SongController {
    constructor(private songService: SongService) {}

    async getAllSongs(request: Request, response: Response): Promise<void> {
        
    }
}

export default SongController;