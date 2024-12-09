import mongoose from "mongoose";

class UserVM {
    constructor(
        public readonly username: string,
        public readonly email: string,
        public readonly password: string,
        public readonly profile: {
            displayName: string,
            avatarUrl: string
        },
        public readonly favoriteSongs: mongoose.Types.ObjectId[],
        public readonly discoverList: mongoose.Types.ObjectId[],
        public readonly followedArtist: mongoose.Types.ObjectId[],
        public readonly playlists: mongoose.Types.ObjectId[],
        public readonly createdAt: string,
        public readonly updatedAt: string,
        public readonly googleId?: string,
    ) {}
}

export default UserVM