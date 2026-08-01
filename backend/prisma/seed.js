import "dotenv/config"; 
import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "@prisma/client";

const adapter = new PrismaPg({connectionString: process.env.DATABASE_URL});
const prisma = new PrismaClient({adapter});

const userId = "0dce5a8c-be88-45c6-b493-9ec291a1363e";

const movies = [
  {
    title: "The Matrix",
    overview: "A computer hacker learns about the true nature of reality.",
    releaseYear: 1999,
    genres: ["Action", "Sci-Fi"],
    runTime: 136,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9wWk_t27UntaeDxSbOvBS6oYqaGi8B4WrXb5C8RiMBg&s=10",
    createdBy: userId,
  },
  {
    title: "Inception",
    overview:
      "A thief who steals corporate secrets through dream-sharing technology.",
    releaseYear: 2010,
    genres: ["Action", "Sci-Fi", "Thriller"],
    runTime: 148,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-8_uZWPkFTz_mlA8Jvr4nqI3rKFsOmoyhgPCbdsVL8w&s=10",
    createdBy: userId,
  },
  {
    title: "The Dark Knight",
    overview: "Batman faces the Joker in a battle for Gotham's soul.",
    releaseYear: 2008,
    genres: ["Action", "Crime", "Drama"],
    runTime: 152,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZeVbJO7aDKXGuVYobj3Cf-y3vi3mU8kHYKOiDvakrHA&s=10",
    createdBy: userId,
  },
  {
    title: "Pulp Fiction",
    overview: "The lives of two mob hitmen, a boxer, and others intertwine.",
    releaseYear: 1994,
    genres: ["Crime", "Drama"],
    runTime: 154,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbJ5yLYK8uz5ZSpjDK8LJvWN5vkMFJeTWnJOLKjtLEkg&s=10",
    createdBy: userId,
  },
  {
    title: "Interstellar",
    overview: "A team of explorers travel through a wormhole in space.",
    releaseYear: 2014,
    genres: ["Adventure", "Drama", "Sci-Fi"],
    runTime: 169,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq0Fc5dVmv4LJ0oO6BPsuP_GRPY7eNzOzFQnD43vrsUA&s=10",
    createdBy: userId,
  },
  {
    title: "The Shawshank Redemption",
    overview: "Two imprisoned men bond over a number of years.",
    releaseYear: 1994,
    genres: ["Drama"],
    runTime: 142,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6sch9oxKCVFnGGErPSqUkiv80A5dDMD_C-0OuUXldhQ&s=10",
    createdBy: userId,
  },
  {
    title: "Fight Club",
    overview:
      "An insomniac office worker and a devil-may-care soapmaker form an underground fight club.",
    releaseYear: 1999,
    genres: ["Drama"],
    runTime: 139,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtWRbioH82ojFeJWWww0_-Jv5S4grmxdHYQ6A8UG71mw&s=10",
    createdBy: userId,
  },
  {
    title: "Forrest Gump",
    overview:
      "The presidencies of Kennedy and Johnson unfold through the perspective of an Alabama man.",
    releaseYear: 1994,
    genres: ["Drama", "Romance"],
    runTime: 142,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8ZbMYhT6dK1T-rsio7-WRk9HgkVSslHjhYfd05ah4MQ&s=10",
    createdBy: userId,
  },
  {
    title: "The Godfather",
    overview:
      "The aging patriarch of an organized crime dynasty transfers control to his son.",
    releaseYear: 1972,
    genres: ["Crime", "Drama"],
    runTime: 175,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZ6HTBVahyli0o4Ob3LNfwKUDH9-kB3EUIAa9zRzLfiw&s=10",
    createdBy: userId,
  },
  {
    title: "Goodfellas",
    overview: "The story of Henry Hill and his life in the mob.",
    releaseYear: 1990,
    genres: ["Biography", "Crime", "Drama"],
    runTime: 146,
    posterUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCHhO_-Z2tceX_O56yDlmJZQQKgHEv7HKgUapd2NaqEQ&s=10",
    createdBy: userId,
  },
];

const main = async () => {
    console.log("Seeding movies...");

    for(const movie of movies) {
        await prisma.movie.create({
            data: movie,

        });
        console.log(`Created movie: ${movie.title}`);


    }
    console.log("Seeding completed");

}; 

// const main = async () => {
//     console.log("Rensar befintliga filmer...");
//     await prisma.movie.deleteMany({});

//     console.log("Seeding movies...");
//     for (const movie of movies) {
//         await prisma.movie.create({
//             data: movie,
//         });
//         console.log(`Created movie: ${movie.title}`);
//     }
//     console.log("Seeding completed");
// };

main()
  .catch((err) => {
    console.error(err);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });