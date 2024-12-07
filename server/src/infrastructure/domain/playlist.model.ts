import mongoose, { Document, Schema } from "mongoose";

export interface IPlaylist extends Document {

};

const PlaylistSchem: Schema = new Schema(
    {

    }
);

export default mongoose.model<IPlaylist>("Playlist", PlaylistSchem);