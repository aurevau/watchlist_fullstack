import "dotenv/config";
import { notFound, errorHandler } from "./middleware/errorMiddleware.js"; 


import express from 'express';
import { connectDB, disconnectDB } from './config/db.js';

// Import routes
import movieRoutes from "./routes/movieRoutes.js";
import authRoutes from "./routes/authRoutes.js";
import watchListRoutes from "./routes/watchlistRoutes.js";


connectDB();

const app = express(); 

// body parsing middlewares 
app.use(express.json()); 
app.use(express.urlencoded({extented: true}));


// API Routes 
app.use("/movies", movieRoutes)
app.use("/auth", authRoutes); 
app.use("/watchlist", watchListRoutes); 

app.use(notFound);
app.use(errorHandler); 



const PORT = 5001; 

const server = app.listen(PORT, () => {
    console.log(`Server running on PORT ${PORT}`);
});

process.on("unhandledRejection", (err) => {
    console.error("Unhandled Rejection:", err);
    server.close(async () => {
        await disconnectDB(); 
        process.exit(1);
    });
});

process.on("uncaughtException", async (err) => {
    console.error("Uncaught Exception:", err); 
    await disconnectDB(); 
    process.exit(1);
});

process.on("SIGTERM", async () => {
    console.log("SIGTERM recieved, shutting down gracefully");
    server.close(async () => {
        await disconnectDB(); 
        process.exit(0);
    });
}); 