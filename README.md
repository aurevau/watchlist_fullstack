# Movie Watchlist
I am currently building full-stack app (Flutter + Node.js/Express/PostgreSQL) that lets you browse a movie catalogue, search it, and keep your own personal watchlist with statuses, ratings, and notes.
I am building this to practice connecting the Flutter frontend to a real backend, and to understand how the backend itself is built. 

## Screenshots
<img width="250" height="544" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-31 at 21 42 46" src="https://github.com/user-attachments/assets/97f42fb7-9ffc-4e7a-af74-22afda5ba1ca" /> <img width="250" height="544" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-31 at 21 43 02" src="https://github.com/user-attachments/assets/44a91111-ec99-40e7-b529-2d3c301541a9" />
<img width="250" height="544" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-31 at 21 43 11" src="https://github.com/user-attachments/assets/24add010-3dca-40af-a0ef-ec98b8704c39" /> <img width="250" height="544" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-31 at 21 43 17" src="https://github.com/user-attachments/assets/bfc6c38f-869c-4fac-8f40-985a149a173d" />
<img width="250" height="544" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-31 at 21 43 20" src="https://github.com/user-attachments/assets/20a48394-f5eb-43f5-83bf-74f62eddf04a" /> <img width="250" height="544" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-31 at 21 43 23" src="https://github.com/user-attachments/assets/638015aa-8c4b-4a1f-979f-f09747ab5fcf" />


## Features
**Browse & Search**
* Browse the full movie catalogue
* Search by title (case-insensitive)
* View details for a single movie

**Personal Watchlist**
* Add any movie to your watchlist
* Set a status: planned, watching, completed, or dropped
* Rate movies from 1–10
* Add free-text notes for each movie
* A movie can only be added once per user

**Accounts & Auth**
* Register and log in with email + password
* Passwords hashed with bcrypt
* JWT-based authentication, token persisted on-device so you stay logged in
* Only the owner of a watchlist item can edit or delete it

**Mobile App**
* Built with Flutter, works across devices
* Bottom tab navigation (Home / Watchlist / Profile), each tab keeps its own scroll/navigation state

## Technical Details
### Architecture
* **Backend:** Node.js, Express 5, Prisma 7, PostgreSQL, JWT auth
* **Frontend:** Flutter, Provider (state management), http, shared_preferences
* **Pattern:** REST API on the backend; Provider-based MVVM-ish state management on the frontend
* Flutter sends requests to Express with a Bearer token → Express routes call controllers → Prisma reads/writes PostgreSQL

### Data Models
Defined in `backend/prisma/schema.prisma`:

**User**
Stores account info:
* id, name, email (unique), password (bcrypt hash), createdAt

**Movie**
Stores catalogue entries:
* id, title, overview, releaseYear, genres, runTime, posterUrl, createdBy, createdAt
* Read-only via the API — populated by the seed script

**WatchListItem**
Links a user to a movie:
* id, userId, movieId, status, rating, notes, createdAt, updatedAt
* Unique per (userId, movieId) — can't add the same movie twice
* Status is one of: `PLANNED`, `WATCHING`, `COMPLETED`, `DROPPED`

### Key Components
```
movie-watchlist/
├── backend/
│   ├── prisma/
│   │   ├── schema.prisma
│   │   ├── migrations/
│   │   └── seed.js
│   └── src/
│       ├── server.js
│       ├── routes/
│       ├── controllers/
│       ├── middleware/
│       └── validators/
└── frontend/
    └── lib/
        ├── main.dart
        ├── models/
        ├── providers/
        ├── pages/
        ├── components/
        └── themes/
```

## How It Works
1. **Register/Login:** create an account or log in; the backend returns a JWT token
2. **Browse:** the app fetches the movie catalogue from `/movies`
3. **Search:** typing a query hits `/movies/search?query=` for a case-insensitive title match
4. **Add to Watchlist:** picking a movie sends a `POST /watchlist`, defaulting to `PLANNED` status
5. **Track Progress:** update status, rating, or notes anytime with `PUT /watchlist/:id`
6. **Stay Logged In:** the token is saved locally with shared_preferences, so you don't have to log in every time

## API Reference

Base URL: `http://localhost:5001` (port is currently hard-coded, just for dev purposes)

**Auth** — `/auth`
* `POST /auth/register` — sign up (name, email, password) → user + token
* `POST /auth/login` — log in (email, password) → user + token
* `POST /auth/logout` — clears the auth cookie
* `GET /auth/me` — get current user (requires token)

**Movies** — `/movies` (read-only)
* `GET /movies` — all movies
* `GET /movies/search?query=` — search by title
* `GET /movies/:id` — single movie

**Watchlist** — `/watchlist` (all require a token)
* `GET /watchlist` — your items, newest first
* `POST /watchlist` — add a movie
* `PUT /watchlist/:id` — update status/rating/notes
* `DELETE /watchlist/:id` — remove an item

Auth header for protected routes:
```
Authorization: Bearer <token>
```

## Environment Variables
The backend needs:
* `DATABASE_URL` — PostgreSQL connection string
* `JWT_SECRET` — secret used to sign tokens
* `JWT_EXPIRES_IN` — token lifetime
* a dev flag to enable Prisma query logs and full stack traces

## Future Enhancements
Potential features for later/things I am currently working on:

* Sorting and filtering the watchlist
* Adding notes and rating to watchlist items
* Add friends and see their watchlist
* Recommendations based on watch history
* Automated tests (backend and frontend)

