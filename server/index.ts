import express from "express";
import mongoose from "mongoose";
import authRouter from "./src/routes/auth.routes";
import artistRouter from "./src/routes/artist.routes";
import genreRouter from "./src/routes/genre.routes";
import songRouter from "./src/routes/song.routes";
import playlistRouter from "./src/routes/playlist.routes";

const app = express();
const PORT = 3000;

app.use("/api/v1/auth", authRouter);
app.use("/api/v1/artist", artistRouter);
app.use("/api/v1/genre", genreRouter);
app.use("/api/v1/song", songRouter);
app.use("/api/v1/playlist", playlistRouter);

const dbURLCompass = `mongodb://localhost:27017/spotify`;
const connectDB = async () => {
  try {
    await mongoose.connect(dbURLCompass);
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
