import { Request, Response } from "express";
import ArtistService from "../application/artist.service";
import ValidationError from "../errors/validation.error";
import ArtistEntity from "../domain/entities/artist.entity";
import ArtistVM from "../infrastructure/viewmodel/artist.vm";

class ArtistController {
  constructor(private artistSerice: ArtistService) {}

  async getAllArtists(request: Request, response: Response): Promise<void> {
    try {
      const artists = await this.artistSerice.getAllArtists();
      response.status(200).json({
        message: "Get all artist success",
        data: artists,
      });
    } catch (error: any) {
       response.status(500).json(error.message);
    }
  }

  async getArtistById(request: Request, response: Response): Promise<void> {
    try {
      const { id } = request.params;
      const artist = await this.artistSerice.getArtistById(id);
      if (artist) {
        response.status(200).json({
          message: "Get artist successfully",
          data: artist,
        });
      } else {
        throw new ValidationError("Artist not found", "artist");
      }
    } catch (error: any) {
      response.status(500).json({ message: error.message });
    }
  }

  async createArtist(request: Request, response: Response): Promise<void> {
    try {
      const { name, bio, avatarUrl, songs, albums, followers } = request.body;
      const existingArtist = await ArtistEntity.findOne({ name });
      if (existingArtist) {
        throw new ValidationError("Artist already existed", "Artist");
      }

      const artist = await this.artistSerice.createArtist(
        new ArtistVM(name, bio, avatarUrl, songs, albums, followers)
      );

      response.status(201).json({
        message: "Create artist successfully",
        data: artist,
      });
    } catch (error: any) {
      response.status(500).json(error.message);
    }
  }

  async updateArtist(request: Request, response: Response): Promise<void> {
    try {
      const { id } = request.params;
      const { name, bio, avatarUrl, songs, albums, followers } = request.body;
      const existingArtist = await ArtistEntity.findById(id);
      if (!existingArtist) {
        throw new ValidationError("Artist not found", "artist");
      }
      const isSameArtist =
        existingArtist.name == name &&
        existingArtist.bio == bio &&
        existingArtist.avatarUrl == avatarUrl &&
        existingArtist.songs == songs &&
        existingArtist.albums == albums &&
        existingArtist.followers == followers;
      if (isSameArtist) {
        throw new ValidationError("No changed detected", "isSameArtist");
      } else {
        const updatedArtist = new ArtistVM(
          name,
          bio,
          avatarUrl,
          songs,
          albums,
          followers
        );
        const artist = await this.artistSerice.updateArtist(id, updatedArtist);
        response.status(200).json({
          message: "Update artist successfully",
          data: artist,
        });
      }
    } catch (error: any) {
      response.status(500).json({ message: error.message });
    }
  }

  async deleteArtist(request: Request, response: Response): Promise<void> {
    try {
      const { id } = request.params;
      const success = await this.artistSerice.deleteArtist(id);
      if (success) {
        response.status(200).json({
          message: "Delete artist successfully",
        });
      } else {
        response.status(400).json({
          message: "Delete artist failed",
        });
      }
    } catch (error: any) {
      response.status(500).json({ message: error.message });
    }
  }
}

export default ArtistController;
