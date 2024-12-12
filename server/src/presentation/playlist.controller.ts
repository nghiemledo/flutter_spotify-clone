import { Request, Response } from "express";
import PlaylistService from "../application/playlist.service";
import playlistEntity from "../domain/entities/playlist.entity";
import PlaylistVM from "../infrastructure/viewmodel/playlist.vm";

class PlaylistController {
    constructor(private playlistService: PlaylistService) {}

    async getAllPlaylists(request: Request, response: Response): Promise<void> {
        try {
            const playlists = await this.playlistService.getAllPlaylist();
            response.status(200).json({
                message: "Get all playlist successfully",
                data: playlists
            })
            
        } catch (err: any) {
            response.status(500).json({
                message: "Internal server error"
            })
        }
    }

    async getPlaylistById(request: Request, response: Response) {
        try {
            const {id} = request.params;
            const playlistFound = await this.playlistService.getPlaylistById(id);
            if(!playlistFound) {
                response.status(400).json({message: "Playlist not foound"})
                return;
            }
            response.status(200).json({
                message: "Playlist found successfully",
                data: playlistFound
            })
        } catch (err: any) {
            response.status(500).json({
                message: "Internal server error"
            })
        }
    }

    async createPlaylist(request: Request, response: Response): Promise<void> {
        try {
            const {name, description, songs, isPublic} = request.body;
            const isExistingPlaylist = await playlistEntity.findOne({name});
            if(isExistingPlaylist) {
                response.status(400).json({message: "Playlist is already exist"});
                return;
            }
            const newPlaylist = new PlaylistVM(name, description, songs, isPublic);
            const result = await this.playlistService.createPlaylist(newPlaylist);

            if(!result) {
                response.status(400).json({message: "Cannot create playlist"});
                return;
            }
            response.status(201).json({
                message: "Create playlist successfully",
                data: result
            });
            
        } catch (err: any) {
            response.status(500).json({
                message: "Internal server error"
            })
        }
    }

    async updatePlaylist(request: Request, response: Response) {
        try {
            const {id} = request.params;
            const {name, description, songs, isPublic} = request.body;

            const playlistFound = await playlistEntity.findById(id);

            const existPlaylist = playlistFound?.name == name &&
            playlistFound?.description == description &&
            playlistFound?.songs == songs &&
            playlistFound?.isPublic == isPublic;

            if(existPlaylist) {
                response.status(400).json({
                    message: "No change detected"
                });
                return;
            } else {
                const newPlaylist = new PlaylistVM(name, description, songs, isPublic);
                const result = await this.playlistService.updatePlaylist(id, newPlaylist);
                if(!result) {
                    response.status(400).json({message: "Playlist update failed"});
                    return;
                } 
                response.status(200).json({
                    message: "Playlist updated successfully",
                    data: result
                })
            }
        } catch (error) {
            response.status(500).json({
                message: "Internal server error"
            })
        }
    }

    async deletePlaylist(request: Request, response: Response) {
      try {
        const {id} = request.params;
        const result = await this.playlistService.deletePlaylist(id);
        if(!result) {
            response.status(400).json({message: "Delete playlist failed"});
            return;
        }
        response.status(200).json({message: "Delete playlist successfully"});
      } catch (error: any) {
        response.status(500).json({message: "Internal server error"});
      }
    }
}

export default PlaylistController;