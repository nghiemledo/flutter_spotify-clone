import ArtistEntity from "../../domain/entities/artist.entity";
import { IArtistRepository } from "../../domain/interfaces/IArtist.repository";
import ArtistVM from "../viewmodel/artist.vm";

class ArtistRepository implements IArtistRepository {   
    async findAll(): Promise<ArtistVM[]> {
        return ArtistEntity.find().populate('songs albums followers').exec();
    }

    async findById(id: string): Promise<ArtistVM | null> {
        return ArtistEntity.findById(id).populate('songs albums followers').exec();
    }

    async create(artist: ArtistVM): Promise<ArtistVM> {
        const newArtist = new ArtistEntity(artist);
        await newArtist.save();
        return newArtist.toObject() as ArtistVM;
    }

    async update(id: string, artist: ArtistVM): Promise<ArtistVM | null> {
        const updatedArtist = await ArtistEntity.findByIdAndUpdate(id, artist, {
            new: true,
            runValidators: true
        });
        return updatedArtist ? updatedArtist.toObject() as ArtistVM : null
    }

    async delete(id: string): Promise<boolean> {
        const result = await ArtistEntity.findByIdAndDelete(id)
        return !!result;
    }
}

export default ArtistRepository;