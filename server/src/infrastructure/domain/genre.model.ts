import mongoose, { Schema } from "mongoose";

export interface IGenre extends Document {

};

const GenreSchema: Schema = new Schema(
    {

    }
);

export default mongoose.model<IGenre>("Genre", GenreSchema);