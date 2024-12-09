import mongoose from "mongoose";

class SongVM {
    constructor(
        public readonly title: string,
        public readonly duration: number,
        public readonly genre: mongoose.Types.ObjectId,
        public readonly artist: mongoose.Types.ObjectId,
        public readonly album: mongoose.Types.ObjectId,
        public readonly fileUrl: string,
        public readonly coverImageUrl: string
    ) {}
}

export default SongVM