import mongoose, { Document, Schema } from "mongoose";

export interface IPlaylist extends Document {
    name: string;
    description: string;
    createdBy: mongoose.Types.ObjectId;
    songs: mongoose.Types.ObjectId[];
    isPublic: boolean;
};

const PlaylistSchem: Schema = new Schema(
    {
        name: { type: String, required: true },
        description: { type: String, default: "" },
        createdBy: { type: Schema.Types.ObjectId, ref: "User", required: true },
        songs: [{ type: Schema.Types.ObjectId, ref: "Song" }],
        isPublic: { type: Boolean, default: false },
    },
    { timestamps: true }
);

export default mongoose.model<IPlaylist>("Playlist", PlaylistSchem);