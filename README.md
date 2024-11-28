
# **Flutter Spotify Clone 🎵**

A feature-rich Spotify-like music streaming app built with **Flutter** (frontend) and **Express.js** (backend). This app allows users to stream songs, create playlists, explore genres, and enjoy music seamlessly.

---

## **Features**
### **User Features**
- 🎶 **Music Streaming**: Play songs directly from the app with high-quality audio.  
- 🔍 **Search**: Find songs, artists, albums, and playlists easily.  
- 📜 **Playlists**: Create, edit, and share custom playlists.  
- 🎧 **Explore Genres**: Discover songs by music genres (Pop, Rock, Jazz, etc.).  
- ❤️ **Favorites**: Mark songs and albums as favorites for quick access.  
- 📊 **Personalized Recommendations**: Get music suggestions based on your listening history.

### **Admin Features**
- 🛠️ **Song Management**: Add, update, or delete songs.  
- 🛠️ **Artist Management**: Manage artist profiles and their discography.  
- 🛠️ **Genre Management**: Add or update genres to organize music.  
- 🛠️ **Album Management**: Maintain album details and associated songs.

---

## **Tech Stack**

### **Frontend**  
- **Framework**: [Flutter](https://flutter.dev/)  
- **UI Toolkit**: Material Design  

### **Backend**  
- **Framework**: [Express.js](https://expressjs.com/)  
- **Database**: MongoDB (with Mongoose ORM)  
- **Authentication**: JSON Web Tokens (JWT)  

### **APIs**  
- Custom RESTful APIs for music streaming, user management, and search functionality.  

### **Deployment**  
- **Frontend**: Deployed on Firebase Hosting  
- **Backend**: Deployed on Heroku  

---

## **Installation Guide**

### **Prerequisites**
- Node.js & npm installed
- Flutter SDK installed
- MongoDB running locally or on the cloud
- A code editor (e.g., VS Code)

### **Backend Setup**
1. Clone the repository:  
   ```bash
   git clone https://github.com/yourusername/spotify-clone-backend.git
   cd spotify-clone-backend
   ```
2. Install dependencies:  
   ```bash
   npm install
   ```
3. Configure environment variables:
   - Create a `.env` file in the root directory.
   - Add the following variables:
     ```
     PORT=5000
     MONGO_URI=your-mongodb-uri
     JWT_SECRET=your-secret-key
     ```
4. Start the server:  
   ```bash
   npm run dev
   ```

### **Frontend Setup**
1. Clone the repository:  
   ```bash
   git clone https://github.com/nghimeledo/flutter_spotify-clone.git
   cd flutter_spotify-clone
   ```
2. Install dependencies:  
   ```bash
   flutter pub get
   ```
3. Run the app:  
   ```bash
   flutter run
   ```

---

## **API Endpoints**
### **Authentication**
- `POST /api/auth/register`: Register a new user  
- `POST /api/auth/login`: Log in a user  

### **Music**
- `GET /api/songs`: Fetch all songs  
- `GET /api/songs/:id`: Fetch a single song  
- `POST /api/songs`: Add a new song (Admin)  
- `PUT /api/songs/:id`: Update song details (Admin)  
- `DELETE /api/songs/:id`: Delete a song (Admin)  

### **Genres**
- `GET /api/genres`: Fetch all genres  
- `GET /api/genres/:id`: Fetch songs in a genre  

### **Playlists**
- `GET /api/playlists`: Fetch user playlists  
- `POST /api/playlists`: Create a new playlist  
- `PUT /api/playlists/:id`: Update playlist details  
- `DELETE /api/playlists/:id`: Delete a playlist  

---

## **Contributing**
We welcome contributions! To get started:  
1. Fork the repository.  
2. Create a new branch (`feature/your-feature`).  
3. Commit your changes and push the branch.  
4. Open a pull request.

---

## **Future Enhancements**
- 🎤 **Podcast Integration**  
- 📱 **Responsive Web Version**  
- 🛒 **Subscription Plans**  
- 📈 **User Analytics Dashboard**  

---

## **License**
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## **Contact**
Feel free to reach out if you have any questions or feedback:  
📧 Email: nghiemledo@gmail.com  

--- 

### **Happy Coding! 🚀** 
