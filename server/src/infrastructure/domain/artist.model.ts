import mongoose, { Schema } from "mongoose";

export interface IArtist extends Document {

};

const ArtistSchema: Schema = new Schema(
    {

    }
);

export default mongoose.model<IArtist>("Artist", ArtistSchema);