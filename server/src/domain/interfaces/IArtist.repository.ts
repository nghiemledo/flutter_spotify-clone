import ArtistVM from "../../infrastructure/viewmodel/artist.vm";

export interface IArtistRepository {
    findAll(): Promise<ArtistVM[]>;
    findById(id: string): Promise<ArtistVM | null>;
    create(artist: ArtistVM): Promise<ArtistVM>;
    update(id: string, artist: ArtistVM): Promise<ArtistVM | null>;
    delete(id: string): Promise<boolean>;
}