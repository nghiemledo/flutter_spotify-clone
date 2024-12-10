import SongVM from "../../infrastructure/viewmodel/song.vm";

export interface ISongRepository {
    findAll(): Promise<SongVM[]>;
    findById(id: string): Promise<SongVM | null>;
    create(song: SongVM): Promise<SongVM>;
    update(id: string, song: SongVM): Promise<SongVM | null>;
    delete(id: string): Promise<boolean>;
}