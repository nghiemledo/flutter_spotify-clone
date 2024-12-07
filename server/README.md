
# **Spotify Clone (Express BE) 🎵**

This is the backend service for the Spotify Clone application, built using **Express.js**, **TypeScript**, and **MongoDB**. It provides RESTful APIs for authentication, user management, music streaming, and playlist handling.

## Features

### **Authentication**
- User registration with hashed passwords (bcrypt)
- Login with JSON Web Tokens (JWT)
- Google OAuth integration

### **Music Management**
- **Genres**: Create, update, delete, and fetch songs by genre
- **Songs**: Search, play, and fetch song details
- **Artists and Albums**: Fetch artist songs, albums, and follow/unfollow artists

### **User Management**
- Profile management
- Manage favorite songs and discovery list

### **Playlists**
- Create, update, delete, and fetch playlists
- Add and remove songs from playlists

---

## Tech Stack

- **Node.js**: Runtime environment
- **Express.js**: Web framework
- **TypeScript**: Type-safe development
- **MongoDB**: NoSQL database
- **Mongoose**: MongoDB object modeling
- **JWT**: Authentication
- **Bcrypt**: Password hashing

---

## Project Structure

```
src/
├── application/     # Reusable service functions
├── errors/          # Handling errors
├── infrastructure/  # Mongoose schemas for MongoDB
├── middlewares/     # Contains functions that handle requests and responses
├── presentation/    # Logic for API endpoints
├── routes/          # Express routes
├── utils/           # Helper functions
└── index.ts         # Server entry point
```

---

## Installation

### Prerequisites
- Node.js >= 16.x
- MongoDB >= 4.x

### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/nghiemledo/flutter_spotify-clone.git
   cd flutter_spotify-clone
   cd server
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Create a `.env` file in the root directory and add the following:
   ```env
   PORT=5000
   MONGO_URI=your_mongodb_connection_string
   JWT_SECRET=your_jwt_secret
   GOOGLE_CLIENT_ID=your_google_client_id
   GOOGLE_CLIENT_SECRET=your_google_client_secret
   ```

4. Start the server:
   ```bash
   npm run dev
   ```

---

## API Endpoints

### **Authentication**
| Method | Endpoint         | Description          |
|--------|------------------|----------------------|
| POST   | `/auth/register` | Register a new user  |
| POST   | `/auth/login`    | Login and get a JWT  |
| GET    | `/auth/google`   | Google OAuth login   |

### **Genres**
| Method | Endpoint            | Description                     |
|--------|---------------------|---------------------------------|
| POST   | `/genres`           | Create a new genre             |
| GET    | `/genres`           | Get all genres                 |
| PATCH  | `/genres/:id`       | Update a genre by ID           |
| DELETE | `/genres/:id`       | Delete a genre by ID           |

### **Users**
| Method | Endpoint            | Description                          |
|--------|---------------------|--------------------------------------|
| GET    | `/users/profile`    | Fetch logged-in user's profile       |
| PATCH  | `/users/profile`    | Update logged-in user's profile      |
| GET    | `/users/favorites`  | Fetch favorite songs                |
| POST   | `/users/favorites`  | Add a song to favorites             |

### **Playlists**
| Method | Endpoint              | Description                          |
|--------|-----------------------|--------------------------------------|
| POST   | `/playlists`          | Create a new playlist               |
| GET    | `/playlists`          | Get all playlists of a user         |
| PATCH  | `/playlists/:id`      | Update a playlist by ID             |
| DELETE | `/playlists/:id`      | Delete a playlist by ID             |

### **Songs**
| Method | Endpoint             | Description                          |
|--------|----------------------|--------------------------------------|
| GET    | `/songs/search`      | Search for songs                    |
| GET    | `/songs/:id`         | Get song details by ID              |
| GET    | `/songs/play/:id`    | Play a song by ID                   |

---

## Scripts

- **`npm run dev`**: Start the server in development mode
- **`npm run build`**: Build the project for production
- **`npm start`**: Start the server in production mode
- **`npm run lint`**: Lint the codebase

---

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m "Add new feature"`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Create a Pull Request

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact

For any inquiries, reach out at [nghiemledo@gmail.com](mailto:nghiemledo@gmail.com).
