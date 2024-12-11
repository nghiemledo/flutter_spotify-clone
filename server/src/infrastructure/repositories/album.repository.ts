import albumEntity from "../../domain/entities/album.entity";
import { IAlbumRepository } from "../../domain/interfaces/IAlbum.repository";
import AlbumVM from "../viewmodel/album.vm";

class AlbumRepository implements IAlbumRepository {
    async findAll(): Promise<AlbumVM[]> {
        return await albumEntity.find().populate('artist songs').exec();
    }

    async findById(id: string): Promise<AlbumVM | null> {
        return await albumEntity.findById(id).populate('artist songs').exec();
    }

    async create(album: AlbumVM): Promise<AlbumVM> {
        const newAlbum = new albumEntity(album);
        await newAlbum.save();
        return newAlbum.toObject() as AlbumVM;
    }

    async update(id: string, album: AlbumVM): Promise<AlbumVM | null> {
        const updateAlbum = await albumEntity.findByIdAndUpdate(id, album, {
            new: true,
            runValidators: true
        });
        return updateAlbum ? updateAlbum.toObject() as AlbumVM : null
    }

    async delete(id: string): Promise<boolean> {
       const result = albumEntity.findByIdAndDelete(id);
        return !!result;
    }
}

export default AlbumRepository;