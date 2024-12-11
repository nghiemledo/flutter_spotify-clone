import { Request, Response } from "express";
import SongService from "../application/song.service";
import songEntity from "../domain/entities/song.entity";
import fs from "fs";
import path from "path";

class SongController {
    constructor(private songService: SongService) {}

    async getAllSongs(request: Request, response: Response): Promise<void> {
        try {
            const songs = await songEntity.find()
                .populate("genre artist album")
                .select("title artist album duration coverImageUrl");
            response.json(songs);
        } catch (error) {
            console.error(error);
            response.status(500).json({ message: "Internal server error" });
        }
    }

    async streamSong(req: Request, res: Response) {
        try {
            const songId = req.params.id;
            const song = await songEntity.findById(songId);
    
            if (!song) {
                return res.status(404).json({ message: "Song not found" });
            }
    
            const filePath = song.fileUrl; // Đường dẫn file nhạc
            const stat = fs.statSync(filePath);
            const fileSize = stat.size;
            const range = req.headers.range;
    
            if (range) {
                // Xử lý streaming theo Range Header
                const parts = range.replace(/bytes=/, "").split("-");
                const start = parseInt(parts[0], 10);
                const end = parts[1] ? parseInt(parts[1], 10) : fileSize - 1;
    
                if (start >= fileSize) {
                    res.status(416).send("Requested range not satisfiable");
                    return;
                }
    
                const chunkSize = end - start + 1;
                const file = fs.createReadStream(filePath, { start, end });
                const headers = {
                    "Content-Range": `bytes ${start}-${end}/${fileSize}`,
                    "Accept-Ranges": "bytes",
                    "Content-Length": chunkSize,
                    "Content-Type": "audio/mpeg",
                };
    
                res.writeHead(206, headers); 
                file.pipe(res);
            } else {
                // Trả về toàn bộ file
                const headers = {
                    "Content-Length": fileSize,
                    "Content-Type": "audio/mpeg",
                };
    
                res.writeHead(200, headers);
                fs.createReadStream(filePath).pipe(res);
            }
        } catch (error) {
            console.error(error);
            res.status(500).json({ message: "Internal server error" });
        }
    }

    async createSong(request: Request, response: Response) {

    }
}

export default SongController;