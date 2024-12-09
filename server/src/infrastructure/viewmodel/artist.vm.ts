import mongoose from "mongoose";

class ArtistVM {
    constructor(
        public readonly name: string,
        public readonly bio: string,
        public readonly avatarUrl: string,
        public readonly songs: mongoose.Types.ObjectId[],
        public readonly albums: mongoose.Types.ObjectId[],
        public readonly followers: mongoose.Types.ObjectId[],
    ) {}
}

export default ArtistVM