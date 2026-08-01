import express from 'express';
import { getAllMovies, searchMovie, getMovieById } from '../controllers/movieController.js';

const router = express.Router();

router.get("/", getAllMovies);
router.get("/search", searchMovie);
router.get("/:id", getMovieById)

// router.get("/", (req, res) => {
//     res.json({httpMethod: "get"});
// });

// router.post("/", (req, res) => {
//     res.json({httpMethod: "put"});
// });

// router.delete("/", (req, res) => {
//     res.json({httpMethod: "delete"});
// });

export default router; 