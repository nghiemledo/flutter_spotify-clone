import GenreVM from "../../infrastructure/viewmodel/genre.vm";

export interface IGenreRepository {
    findAll(): Promise<GenreVM[]>;
    findById(id: string): Promise<GenreVM | null>;
    create(genre: GenreVM): Promise<GenreVM>;
    update(id: string, genre: GenreVM): Promise<GenreVM | null>;
    delete(id: string): Promise<boolean>;
}