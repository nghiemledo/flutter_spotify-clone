import mongoose, { Schema } from "mongoose";

export interface IArtist extends Document {
    name: string;
    bio: string;
    avatarUrl: string;
    songs: mongoose.Types.ObjectId[];
    albums: mongoose.Types.ObjectId[];
    followers: mongoose.Types.ObjectId[];
};

const ArtistSchema: Schema = new Schema(
    {
        name: { type: String, required: true },
        bio: { type: String, default: "" },
        avatarUrl: { type: String, default: "" },
        songs: [{ type: Schema.Types.ObjectId, ref: "Song" }],
        albums: [{ type: Schema.Types.ObjectId, ref: "Album" }],
        followers: [{ type: Schema.Types.ObjectId, ref: "User" }],
    },
    { timestamps: true }
);

export default mongoose.model<IArtist>("Artist", ArtistSchema);