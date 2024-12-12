import mongoose from "mongoose";

class AlbumVM {
    constructor(
        public readonly title: string,
        public readonly artist: mongoose.Types.ObjectId,
        public readonly coverImageUrl: string,
        public readonly releaseDate: string,
        public readonly songs: mongoose.Types.ObjectId[],
    ) {}
}

export default AlbumVM