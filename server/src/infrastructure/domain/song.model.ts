import mongoose, { Schema, Document } from "mongoose";

export interface ISong extends Document {

};

const SongSchema: Schema = new Schema(
    {

    }
);

export default mongoose.model<ISong>("Song", SongSchema);