import { IPlaylistRepository } from "../../domain/interfaces/IPlaylist.repository";
import PlaylistVM from "../viewmodel/playlist.vm";

class PlaylistRepository implements IPlaylistRepository {
    findAll(): Promise<PlaylistVM[]> {
        throw new Error("Method not implemented.");
    }
    findById(id: string): Promise<PlaylistVM | null> {
        throw new Error("Method not implemented.");
    }
    create(playlist: PlaylistVM): Promise<PlaylistVM> {
        throw new Error("Method not implemented.");
    }
    update(id: string, playlist: PlaylistVM): Promise<PlaylistVM | null> {
        throw new Error("Method not implemented.");
    }
    delete(id: string): Promise<boolean> {
        throw new Error("Method not implemented.");
    }
}

export default PlaylistRepository;