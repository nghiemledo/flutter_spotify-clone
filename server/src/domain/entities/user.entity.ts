import mongoose, {Schema, Document, Date} from "mongoose";

export interface IUser extends Document {
    username: string;
    email: string;
    password: string;
    googleId?: string;
    profile: {
        displayName: string,
        avatarUrl: string
    };
    favoriteSongs: mongoose.Types.ObjectId[];
    discoverList: mongoose.Types.ObjectId[];
    followedArtist: mongoose.Types.ObjectId[];
    playlists: mongoose.Types.ObjectId[];
};

const UserSchema: Schema = new Schema (
    {
        username: {type: String, required:true},
        email: {type: String, required: true, unique: true},
        password: {type: String, required: true},
        googleId: {type: String},
        profile: {
            displayName: {type: String, default: ""},
            avatarUrl: {type: String, default: ""}
        },
        favoriteSongs: [{type: Schema.Types.ObjectId, ref: "Song"}],
        discoverList: [{type: Schema.Types.ObjectId, ref: "Song"}],
        followedArtist: [{type: Schema.Types.ObjectId, ref: "Artist"}],
        playlists: [{type: Schema.Types.ObjectId, ref: "Playlist"}]
    }, 
    {timestamps: true}
);

export default mongoose.model<IUser>("User", UserSchema);