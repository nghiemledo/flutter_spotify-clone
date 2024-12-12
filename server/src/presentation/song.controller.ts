import { Request, Response } from "express";
import SongService from "../application/song.service";
import songEntity from "../domain/entities/song.entity";
import fs from "fs";
import path from "path";
import { v2 as cloudinary } from 'cloudinary';
import multer from 'multer';
import axios from "axios";

const storage = multer.memoryStorage(); 
const upload = multer({ storage: storage }).single('file'); 

const CLOUDINARY_CLOUD_NAME='djnfhdvkx'
const CLOUDINARY_API_KEY='639835913919659'
const CLOUDINARY_API_SECRET='0cBWMwHvbtGQTjgnxN2MLjYBujE'

cloudinary.config({
    cloud_name: CLOUDINARY_CLOUD_NAME,
    api_key: CLOUDINARY_API_KEY,
    api_secret: CLOUDINARY_API_SECRET,
});


class SongController {
    constructor(private songService: SongService) {}

    async getAllSongs(request: Request, response: Response): Promise<void> {
        try {
            const songs = await songEntity.find()
                .populate("genre artist album")
                .select("title artist album duration coverImageUrl").exec();
            response.status(200).json({
                message: "Get all songs successfully",
                data: songs
            });
        } catch (error: any) {
            response.status(500).json({ message: error.message || "Internal server error" });
        }
    }

    async getSongById(request: Request, response: Response): Promise<void> {
        try {
            const {songId} = request.params;
            const result = await songEntity.findById(songId);
            response.status(200).json({
                message: "Get song successfully",
                data: result
            })
        } catch (error: any) {
            response.status(500).json({ message: error.message || "Internal server error" });
        }
    }

    // async streamSong(req: Request, res: Response): Promise<void> {
    //     try {
    //         const songId = req.params.songId;
    //         const song = await songEntity.findById(songId);
    
    //         if (!song) {
    //              res.status(404).json({ message: "Song not found" });
    //              return;
    //         }
    
    //         const filePath = song.fileUrl; // Đường dẫn file nhạc
    //         const stat = fs.statSync(filePath);
    //         const fileSize = stat.size;
    //         const range = req.headers.range;
    
    //         if (range) {
    //             // Xử lý streaming theo Range Header
    //             const parts = range.replace(/bytes=/, "").split("-");
    //             const start = parseInt(parts[0], 10);
    //             const end = parts[1] ? parseInt(parts[1], 10) : fileSize - 1;
    
    //             if (start >= fileSize) {
    //                 res.status(416).send("Requested range not satisfiable");
    //                 return;
    //             }
    
    //             const chunkSize = end - start + 1;
    //             const file = fs.createReadStream(filePath, { start, end });
    //             const headers = {
    //                 "Content-Range": `bytes ${start}-${end}/${fileSize}`,
    //                 "Accept-Ranges": "bytes",
    //                 "Content-Length": chunkSize,
    //                 "Content-Type": "audio/mpeg",
    //             };
    
    //             res.writeHead(206, headers); 
    //             file.pipe(res);
    //         } else {
    //             // Trả về toàn bộ file
    //             const headers = {
    //                 "Content-Length": fileSize,
    //                 "Content-Type": "audio/mpeg",
    //             };
    
    //             res.writeHead(200, headers);
    //             fs.createReadStream(filePath).pipe(res);
    //         }
    //     } catch (error: any) {
    //         console.error(error);
    //         res.status(500).json({ message: error.message || "Internal server error" });
    //     }
    // }

    async streamSong(req: Request, res: Response): Promise<void> {
        try {
            const songId = req.params.songId;
            const song = await songEntity.findById(songId);
    
            if (!song) {
                 res.status(404).json({ message: "Song not found" });
                 return;
            }
    
            const fileUrl = song.fileUrl; // URL từ Cloudinary
    
            // Stream the file from Cloudinary URL
            const response: any = await axios.get(fileUrl, { responseType: 'stream' });
    
            // Set headers for the response
            res.setHeader('Content-Type', 'audio/mpeg'); // Assuming it's an mp3 file
            res.setHeader('Content-Length', response.headers['content-length']);
            
            // Pipe the response from Cloudinary to the client
            response.data.pipe(res);
        } catch (error) {
            console.error(error);
            res.status(500).json({ message: "Internal server error" });
        }
    }

    async uploadSong(req: Request, res: Response) {
        try {
            upload(req, res, async (err: any) => {
                if (err) {
                    return res.status(400).json({ message: 'File upload error', error: err.message });
                }

                const file = req.file; 

                if (!file) {
                    return res.status(400).json({ message: 'No file uploaded' });
                }

                cloudinary.uploader.upload_stream(
                    {
                        resource_type: 'auto', 
                        folder: 'songs', 
                    },
                    async (error, result) => {
                        if (error) {
                            return res.status(500).json({ message: 'Cloudinary upload error', error });
                        }

                        const fileUrl = result?.secure_url;

                        const { title, duration, genre, artist, album, lyrics, coverImageUrl, isFavorite } = req.body;

                        const newSong = new songEntity({
                            title,
                            duration,
                            genre,
                            artist,
                            album,
                            fileUrl, 
                            lyrics,
                            coverImageUrl,
                            isFavorite: isFavorite || false,
                        });

                        await newSong.save();

                        return res.status(201).json({
                            message: 'Song uploaded successfully',
                            data: newSong,
                        });
                    }
                ).end(file.buffer); 
            });
        } catch (error: any) {
            res.status(500).json({ message: 'Internal server error', error: error.message });
        }
    }

    async deleteSong(request: Request, response: Response): Promise<void> {
        try {
            const { id } = request.params;
            console.log("Id song: " + id);
            
            const result = await this.songService.deleteSong(id);
            
            if(!result) {
                response.status(400).json({
                    message: "Delete song failed"
                });
                return;
            } 
            response.status(200).json({
                message: "Delete song successfully"
            })
        } catch (error: any) {
            response.status(500).json({ message: 'Internal server error', error: error.message });
        }
    }
 
}

export default SongController;