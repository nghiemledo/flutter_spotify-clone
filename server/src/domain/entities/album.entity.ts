import mongoose, { Document, Schema } from "mongoose";

export interface IAlbum extends Document {
    title: string,
    artist: mongoose.Types.ObjectId,
    coverImageUrl: string,
    releaseDate: string,
    songs: mongoose.Types.ObjectId[]
}

const AlbumSchema: Schema = new Schema (
    {
        title: {type: String, required: true},
        artist: { type: mongoose.Types.ObjectId, ref: "Artist" }, 
        coverImageUrl: String,
        releaseDate: Date,
        songs: [{ type: mongoose.Types.ObjectId, ref: "Song" }],         
    }, 
    { timestamps: true }
);

export default mongoose.model<IAlbum>("Album", AlbumSchema);