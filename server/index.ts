import express from "express";
import dotenv from 'dotenv';
import 'express-async-errors';
import bodyParser from "body-parser";
import cors from 'cors';
import morgan from "morgan";
import mongoose from "mongoose";
import authRouter from "./src/routes/auth.routes";
import artistRouter from "./src/routes/artist.routes";
import genreRouter from "./src/routes/genre.routes";
import songRouter from "./src/routes/song.routes";
import playlistRouter from "./src/routes/playlist.routes";
import albumRouter from "./src/routes/album.routes";

const app = express();
dotenv.config();
app.use(express.urlencoded());
app.use(express.json());
app.use(morgan("combined"));
app.use(cors());

const PORT = process.env.PORT;

app.use("/api/v1/auth", authRouter);
app.use("/api/v1/artist", artistRouter);
app.use("/api/v1/genre", genreRouter);
app.use("/api/v1/song", songRouter);
app.use("/api/v1/playlist", playlistRouter);
app.use("/api/v1/album", albumRouter);

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.DBURL!);
    console.log("Db connect successfully");
  } catch (error) {
    console.log("Cannot connect to db: " + error);
  }
};

connectDB()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`Server is running at http://localhost:${PORT}`);
    });
  })
  .catch((error) => {
    console.log(error);
  });

export default app;