import { Request, Response } from "express";
import AlbumService from "../application/album.service";
import AlbumVM from "../infrastructure/viewmodel/album.vm";
import albumEntity from "../domain/entities/album.entity";

class AlbumController {
    constructor(private albumService: AlbumService) {}

    async getAllAlbums(request: Request, response: Response): Promise<void>  {
        try {
            const result = await this.albumService.getAllAlbums();
            if(!result) {
                response.status(400).json({message: "Get album failed due to some reasons"});
                return;
            }
            response.status(201).json({message: "Get album successfully", data: result});
        } catch (error: any) {
            response.status(500).json({message: error.message || "Internal server error"  })
        }
    }

    async getAlbumById(request: Request, response: Response): Promise<void> {
        try {
            const {id} = request.params;
            const albumFound = await this.albumService.getAlbumById(id);

            response.status(200).json({
                message: "Get album successfully",
                data: albumFound
            })
        } catch (error: any) {
            response.status(500).json({message: error.message || "Internal server error"  })
        }
    }

    async createAlbum(request: Request, response: Response): Promise<void>{
        try {
            const {title, artist, coverImageUrl, releaseDate, songs} = request.body;
            const existingAlbum = await albumEntity.findOne({title});
            if(existingAlbum) {
                response.status(400).json({
                    message: "Album already existed"
                })
                return;
            }

            const newAlbum = new AlbumVM(title, artist, coverImageUrl, releaseDate, songs);
            const result = await this.albumService.createAlbum(newAlbum);
            if(!result) {
                response.status(400).json({
                    message: "Create album failed"
                })
                return;
            }
            response.status(201).json({
                message: "Create album successfully",
                data: result
            })
        } catch (error: any) {
            response.status(500).json({message: error.message || "Internal server error"  })
        }
    }

    async updateAlbum(request: Request, response: Response): Promise<void> {
        try {
            const {id} = request.params;
            const {title, artist, coverImageUrl, releaseDate, songs} = request.body;

            const albumFound = await albumEntity.findById(id);

            const isAlbumChanged = albumFound?.title == title &&
            albumFound?.artist == artist &&
            albumFound?.coverImageUrl == coverImageUrl &&
            albumFound?.releaseDate == releaseDate &&
            albumFound?.songs == songs

            if(!isAlbumChanged) {
                response.status(400).json({
                    message: "No changed detected"
                })
                return;
            } else {
                const updateAlbum = new AlbumVM(title, artist, coverImageUrl, releaseDate, songs);
                const data = await this.albumService.updateAlbum(id, updateAlbum);
                if(!data) {
                    response.status(400).json({
                        message: "Update album failed"
                    })
                    return;
                }
                response.status(200).json({
                    message: "Update album successfully",
                    data: data
                })
                return;
            }
        } catch (error: any) {
            response.status(500).json({message: error.message || "Internal server error"  });            
        }
    }

    async deleteAlbum(request: Request, response: Response): Promise<void> {
        try {
            const { id } = request.params;
            const result = await this.albumService.deleteAlbum(id);

            response.status(200).json({
                message: "Delete album successfully"
            })
        } catch (error: any) {
            response.status(500).json({message: error.message || "Internal server error"  });            
            
        }
    }
}

export default AlbumController;