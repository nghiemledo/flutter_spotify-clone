import mongoose from "mongoose";

class AlbumVM {
    constructor(
        public readonly title: string,
        public readonly artist: mongoose.Types.ObjectId,
        public readonly coverImageUrl: string,
        public readonly songs: mongoose.Types.ObjectId[],
        public readonly releaseDate?: string,
    ) {}
}

export default AlbumVM