import mongoose, { Schema, Document } from "mongoose";

export interface ISong extends Document {
    title: string; 
    duration: number;
    genre: mongoose.Types.ObjectId;
    artist: mongoose.Types.ObjectId;
    album: mongoose.Types.ObjectId;
    fileUrl: string;
    coverImageUrl: string;
};

const SongSchema: Schema = new Schema(
    {
        title: { type: String, required: true },
        duration: { type: Number, required: true },
        genre: { type: Schema.Types.ObjectId, ref: "Genre", required: true },
        artist: { type: Schema.Types.ObjectId, ref: "Artist", required: true },
        album: { type: Schema.Types.ObjectId, ref: "Album" },
        fileUrl: { type: String, required: true },
        coverImageUrl: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model<ISong>("Song", SongSchema);