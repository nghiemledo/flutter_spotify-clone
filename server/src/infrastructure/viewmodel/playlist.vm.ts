import mongoose from "mongoose";

class PlaylistVM {
    constructor(
        public readonly name: string,
        public readonly description: string,
        public readonly songs: mongoose.Types.ObjectId[],
        public readonly isPublic: boolean,
        public readonly createdBy?: mongoose.Types.ObjectId,
    ) {}
}

export default PlaylistVM