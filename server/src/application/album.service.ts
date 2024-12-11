import AlbumRepository from "../infrastructure/repositories/album.repository";
import AlbumVM from "../infrastructure/viewmodel/album.vm";

class AlbumService {
    constructor(private albumRepositor: AlbumRepository) {}

    async getAllAlbums(): Promise<AlbumVM[]> {
        return this.albumRepositor.findAll();
    }

    async getAlbumById(id: string): Promise<AlbumVM | null>{
        return await this.albumRepositor.findById(id);
    }

    async createAlbum(album: AlbumVM): Promise<AlbumVM> {
        return await this.albumRepositor.create(album);
    }

    async updateAlbum(id: string, album: AlbumVM): Promise<AlbumVM | null> {
        return await this.albumRepositor.update(id, album);
    }

    async deleteAlbum(id: string): Promise<boolean> {
        return this.albumRepositor.delete(id);
    }
}

export default AlbumService