import { ISongRepository } from "../../domain/interfaces/ISong.repository";
import SongVM from "../viewmodel/song.vm";

class SongRepository implements ISongRepository {
    findAll(): Promise<SongVM[]> {
        throw new Error("Method not implemented.");
    }
    findById(id: string): Promise<SongVM | null> {
        throw new Error("Method not implemented.");
    }
    create(song: SongVM): Promise<SongVM> {
        throw new Error("Method not implemented.");
    }
    update(id: string, song: SongVM): Promise<SongVM | null> {
        throw new Error("Method not implemented.");
    }
    delete(id: string): Promise<boolean> {
        throw new Error("Method not implemented.");
    }
}

export default SongRepository;