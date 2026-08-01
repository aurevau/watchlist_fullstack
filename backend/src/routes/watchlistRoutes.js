import express from "express"; 
import {addToWatchList, getUserWatchlist, removeFromWatchList, updateWatchlistItem} from '../controllers/watchlistController.js';
import { authMiddleware } from "../middleware/authMiddleware.js";
import { validateRequest } from "../middleware/validateRequestMiddleware.js";
import { addToWatchListSchema } from "../validators/watchlistValidators.js";
import { updateMovieSchema } from "../validators/movieValidators.js";

const router = express.Router();

// This applies this middleware to all routes in here
router.use(authMiddleware);

// But if i wanted it on a specific route, i would write: 
// router.post("/", authMiddleware, addToWatchList);

router.post("/", validateRequest(addToWatchListSchema),addToWatchList);

router.delete("/:id", removeFromWatchList);

router.put("/:id", validateRequest(updateMovieSchema) ,updateWatchlistItem);
router.get("/", getUserWatchlist);

export default router; 

