import GenreEntity from "../../domain/entities/genre.entity";
import { IGenreRepository } from "../../domain/interfaces/IGenre.repository";
import GenreVM from "../viewmodel/genre.vm";

class GenreRepository implements IGenreRepository {
    async findAll(): Promise<GenreVM[]> {
        return GenreEntity.find().exec();
    }

    async findById(id: string): Promise<GenreVM | null> {
        return GenreEntity.findById(id).exec();
    }

    async create(genre: GenreVM): Promise<GenreVM> {
        const newGenre = new GenreEntity(genre);
        await newGenre.save();
        return newGenre.toObject() as GenreVM;
    }

    async update(id: string, genre: GenreVM): Promise<GenreVM | null> {
        const updatedGenre = await GenreEntity.findByIdAndUpdate(id, genre, {
            new: true,
            runValidators: true
        });
        return updatedGenre ? updatedGenre.toObject() as GenreVM : null
    }

    async delete(id: string): Promise<boolean> {
        const result = await GenreEntity.findByIdAndDelete(id);
        return !!result;
    }
}

export default GenreRepository;