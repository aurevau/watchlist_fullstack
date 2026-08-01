import {prisma} from "../config/db.js";

const getAllMovies = async (req, res) => {
    const movies = await prisma.movie.findMany();

    res.status(200).json({
        status: "success",
        data: {movies},
    });
};

const searchMovie = async (req, res) => {
    const {query} = req.query;

    if(!query) {
        return res.status(400).json({error: 'Query parameter is required' });
    }
    
    const movies = await prisma.movie.findMany({
        where: {
            title: {
                contains: query,
                mode: "insensitive"
            },
        },
    });

    res.status(200).json({
        status: "success",
        data: {movies},
    });
};

const getMovieById = async (req, res) => {
    const movie = await prisma.movie.findUnique({
        where: {id: req.params.id},
    });

    if (!movie) {
        return res.status(404).json({error: "Movie not found"});
    }

    res.status(200).json({
        status: "success",
        data: {movie},
    });
};

export {getAllMovies, searchMovie, getMovieById};