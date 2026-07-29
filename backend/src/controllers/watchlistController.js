import { prisma } from "../config/db.js";


const addToWatchList = async (req, res) => {
    const {movieId, status, rating, notes} = req.body;

    // Verify movie exists in the movies table 
    const movie = await prisma.movie.findUnique({
        where: {id: movieId},
    });

    if (!movie) {
        return res.status(404).json({
            error: "Movie not found"
        });
    }

    // check if already added
    const existingInWatchList = await prisma.watchListItem.findUnique({
        where: {userId_movieId: {
            userId: req.user.id, 
            movieId: movieId,
        }},
    });

    if (existingInWatchList) {
        return res.status(400).json({
            error: "Movie already in watchlist"
        });
    }

    const watchListItem = await prisma.watchListItem.create({
        data: {
            userId: req.user.id, 
            movieId,
            status: status ? status.toUpperCase() : "PLANNED",
            rating, 
            notes

        },
    });

    res.status(201).json({
        status: "Sucess",
        data: {
            watchListItem
        }
    });

};

const removeFromWatchList = async (req, res) => {
    // find watchlist item and verify ownership
    const watchlistItem = await prisma.watchListItem.findUnique({
        where: {id: req.params.id},
    });

    if (!watchlistItem) {
        return res.status(404).json({error: "Watchlist item not found"});
    }

    // Ensure only owner can delete 
    if (watchlistItem.userId !== req.user.id) {
        return res.status(403).json({error: "Not allowed to update this watchlist item"});
    }

    await prisma.watchListItem.delete({
        where: {id: req.params.id},
    });

    res.status(200).json({
        status: "success",
        message: "Movie removed from watchlist",
    });
};

/**
 * Update watchlist item
 * Updates status, rating or notes
 * Ensuers only owner can update
 * Requires protect middleware 
 */

const updateWatchlistItem = async (req, res) => {
    const {status, rating, notes} = req.body;

    // Find watchlist item and verify ownership
    const watchlistItem = await prisma.watchListItem.findUnique({
        where: {id: req.params.id},
    });

    if (!watchlistItem) {
        return res.status(404).json({error: "Watchlist item not found"});
    }

    // Ensure only owner can update 
    if (watchlistItem.userId !== req.user.id) {
        return res.status(403).json({error: "Not allowed to update this watchlist item"});
    }

    // Build update data
    const updateData = {};
    if(status !== undefined) updateData.status = status.toUpperCase();
    if(rating !== undefined) updateData.rating = rating; 
    if (notes !== undefined) updateData.notes = notes;

    // Update watchlist item
    const updatedItem = await prisma.watchListItem.update({
        where: {id: req.params.id},
        data: updateData,
    });

    res.status(200).json({
        status: "success",
        data: {
            watchlistItem: updatedItem
        }
    });
};


export {addToWatchList, removeFromWatchList, updateWatchlistItem}; 