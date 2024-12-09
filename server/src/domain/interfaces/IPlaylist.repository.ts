import PlaylistVM from "../../infrastructure/viewmodel/playlist.vm";

export interface IPlaylistRepository {
    findAll(): Promise<PlaylistVM[]>;
    findById(id: string): Promise<PlaylistVM | null>;
    create(playlist: PlaylistVM): Promise<PlaylistVM>;
    update(id: string, playlist: PlaylistVM): Promise<PlaylistVM | null>;
    delete(id: string): Promise<boolean>;
}