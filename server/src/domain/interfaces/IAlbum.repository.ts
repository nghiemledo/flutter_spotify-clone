import AlbumVM from "../../infrastructure/viewmodel/album.vm";

export interface IAlbumRepository {
    findAll(): Promise<AlbumVM[]>;
    findById(id: string): Promise<AlbumVM | null>;
    create(album: AlbumVM): Promise<AlbumVM>;
    update(id: string, album: AlbumVM): Promise<AlbumVM | null>;
    delete(id: string): Promise<boolean>;
}