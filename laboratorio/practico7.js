// -------------- MONGO DB --------------------- //

// Para correr, ir al directorio con todos los archivos
// de datos de la base mongo.
// y correr
// sudo docker start mongo-labs
// $ mongo --host 172.17.0.2

// -------------------------------------------------------------------------- //
// ------------------------- PIPELINE DE AGREGACIÓN ------------------------- //
// -------------------------------------------------------------------------- //

// Cantidad de cines (theaters) por estado
db.theaters.aggregate([
  {
    $group: {
      _id: "$location.address.state",
      count_per_state: { $count: {} },
    },
  },
]);

// Cantidad de estados con al menos dos cines (theaters) registrados.
db.theaters.aggregate([
  {
    $group: {
      _id: "$location.address.state",
      count_per_state: { $count: {} },
    },
  },
  {
    $match: {
      count_per_state: { $gte: 2 },
    },
  },
]);

// Cantidad de películas dirigidas por "Louis Lumière".
// Se puede responder sin pipeline de agregación, realizar ambas queries.

db.movies.aggregate([
  {
    $match: {
      directors: { $all: ["Louis Lumière"] },
    },
  },
  {
    $group: {
      _id: null,
      count_movies: { $count: {} },
    },
  },
]);

db.movies.count({
  directors: { $all: ["Louis Lumière"] },
});

// Cantidad de películas estrenadas en los años 50 (desde 1950 hasta 1959).
// Se puede responder sin pipeline de agregación, realizar ambas queries.

db.movies.aggregate([
  {
    $match: {
      year: { $gte: 1950, $lte: 1959 },
    },
  },
  {
    $group: {
      _id: null,
      count_movies: { $count: {} },
    },
  },
]);

db.movies.count({
  year: { $gte: 1950, $lte: 1959 },
});

// Listar los 10 géneros con mayor cantidad de películas (tener en cuenta que
// las películas pueden tener más de un género). Devolver el género y la
// cantidad de películas. Hint: unwind puede ser de utilidad

db.movies.aggregate([
  {
    $unwind: "$genres",
  },
  {
    $group: {
      _id: "$genres",
      count_genres: { $count: {} },
    },
  },
  {
    $sort: { count_genres: -1 },
  },
  {
    $limit: 10,
  },
]);

// Top 10 de usuarios con mayor cantidad de comentarios,
// mostrando Nombre, Email y Cantidad de Comentarios.

db.comments.aggregate([
  {
    $group: {
      _id: {
        name: "$name",
        email: "$email",
      },
      comments: { $count: {} },
    },
  },
  {
    $sort: { comments: -1 },
  },
  {
    $limit: 10,
  },
]);

// Ratings de IMDB promedio, mínimo y máximo por año de las películas
//  estrenadas en los años 80 (desde 1980 hasta 1989), ordenados de mayor
// a menor por promedio del año.
db.movies.aggregate([
  {
    $match: {
      year: { $gte: 1980, $lte: 1989 },
      "imdb.rating": { $type: "double" },
    },
  },
  {
    $group: {
      _id: "$year",
      avg_rating: { $avg: "$imdb.rating" },
      min_rating: { $min: "$imdb.rating" },
      max_rating: { $max: "$imdb.rating" },
    },
  },
  {
    $sort: {
      _id: 1,
      avg_rating: -1,
    },
  },
]);

// Título, año y cantidad de comentarios de las 10 películas con más comentarios.
db.comments.aggregate([
  {
    $group: {
      _id: "$movie_id",
      comments: { $count: {} },
    },
  },
  {
    $lookup: {
      from: "movies",
      localField: "_id",
      foreignField: "_id",
      as: "movie",
    },
  },
  {
    $project: {
      _id: 0,
      "movie.title": 1,
      "movie.year": 1,
      comments: 1,
    },
  },
  {
    $sort: {
      comments: -1,
    },
  },
  {
    $limit: 10,
  },
]);

// Crear una vista con los 5 géneros con mayor cantidad de
// comentarios, junto con la cantidad de comentarios.

db.createView("commented_genres", "movies", [
  {
    $unwind: "$genres",
  },
  {
    $lookup: {
      from: "comments",
      localField: "_id",
      foreignField: "movie_id",
      as: "comment",
    },
  },
  {
    $group: {
      _id: "$genres",
      count_comments: { $count: {} },
    },
  },
  {
    $project: {
      count_comments: 1,
    },
  },
  {
    $sort: { comments: -1 },
  },
  {
    $limit: 5,
  },
]);

// Listar los actores (cast) que trabajaron en 2 o más películas dirigidas
// por "Jules Bass". Devolver el nombre de estos actores junto con la lista
// de películas (solo título y año) dirigidas por “Jules Bass” en las
// que trabajaron.

// Hint1: addToSet
// Hint2: {'name.2': {$exists: true}} permite filtrar arrays con al menos
// 2 elementos, entender por qué.
// Hint3: Puede que tu solución no use Hint1 ni Hint2 e igualmente sea correcta

db.movies.aggregate([
  {
    $unwind: "$cast",
  },
  {
    $match: {
      directors: { $elemMatch: { $eq: "Jules Bass" } },
    },
  },
  {
    $group: {
      _id: "$cast",
      movie: {
        $addToSet: {
          title: "$title",
          year: "$year",
        },
      },
      count: {
        $count: {},
      },
    },
  },
  {
    $match: {
      "movie.1": {
        $exists: true,
      },
    },
  },
  {
    $project: {
      _id: 0,
      Actor: "$_id",
      movie: "$movie",
      Amount: "$count",
    },
  },
]);

// Listar los usuarios que realizaron comentarios durante el mismo mes de
// lanzamiento de la película comentada, mostrando Nombre, Email, fecha del
// comentario, título de la película, fecha de lanzamiento. HINT: usar $lookup
// con multiple condiciones.

db.comments.aggregate([
  {
    $lookup: {
      from: "movies",
      localField: "movie_id",
      foreignField: "_id",
      let: {
        comment_date: "$date",
      },
      pipeline: [
        {
          $match: {
            released: {
              $type: "date",
            },
          },
        },
        {
          $addFields: {
            month_diff: {
              $dateDiff: {
                startDate: "$released",
                endDate: "$$comment_date",
                unit: "month",
              },
            },
          },
        },
        {
          $match: {
            month_diff: {
              $eq: 0,
            },
          },
        },
      ],
      as: "movie",
    },
  },
  // usar como un diccionario y sacar los que eran listas vacías
  {
    $unwind: {
      path: "$movie",
      preserveNullAndEmptyArrays: false,
    },
  },
  {
    $project: {
      name: "$name",
      email: "$email",
      comment_date: "$date",
      movie_title: "$movie.title",
      movie_date: "$movie.released",
    },
  },
]);

// Listar el id y nombre de los restaurantes
// junto con su puntuación máxima, mínima y la
// suma total. Se puede asumir que el
// restaurant_id es único.
// Resolver con $group y accumulators.

db.restaurants.aggregate([
  {
    $unwind: {
      path: "$grades",
    },
  },
  {
    $group: {
      _id: {
        restaurant_id: "$restaurant_id",
        name: "$name",
      },
      max_grade: { $max: "$grades.score" },
      min_grade: { $min: "$grades.score" },
      total: { $sum: "$grades.score" },
    },
  },
]);

// Resolver con expresiones sobre arreglos
// (por ejemplo, $sum) pero sin $group.

db.restaurants.aggregate([
  {
    $addFields: {
      total: { $sum: "$grades.score" },
      max_grade: { $max: "$grades.score" },
      min_grade: { $min: "$grades.score" },
    },
  },
  {
    $project: {
      _id: 0,
      id: "$restaurant_id",
      name: "$name",
      total_grade: "$total",
      max_grade: "$max_grade",
      min_grade: "$min_grade",
    },
  },
]);

// Resolver como en el punto b) pero usar
// $reduce para calcular la puntuación total.
db.restaurants.aggregate([
  {
    $project: {
      _id: 0,
      id: "$restaurant_id",
      name: "$name",
      max_grade: { $max: "$grades.score" },
      min_grade: { $min: "$grades.score" },
      total: {
        $reduce: {
          input: "$grades.score",
          initialValue: 0,
          in: { $add: ["$$value", "$$this"] },
        },
      },
    },
  },
]);

// Resolver con find.

db.restaurants.find(
  {},
  {
    _id: 0,
    id: "$restaurant_id",
    name: "$name",
    max_grade: { $max: "$grades.score" },
    min_grade: { $min: "$grades.score" },
    total: { $sum: "$grades.score" },
  }
);

// Actualizar los datos de los restaurantes añadiendo dos
// campos nuevos.
// "average_score": con la puntuación promedio
// "grade": con "A" si "average_score" está entre 0 y 13,
//   con "B" si "average_score" está entre 14 y 27
//   con "C" si "average_score" es mayor o igual a 28
// Se debe actualizar con una sola query.
// HINT1. Se puede usar pipeline de agregación con la
// operación update
// HINT2. El operador $switch o $cond pueden ser de ayuda.
db.restaurants.updateMany({}, [
  {
    $addFields: {
      average_score: { $avg: "$grades.score" },
      grade: {
        $switch: {
          branches: [
            {
              case: {
                $and: [
                  { $gte: ["$average_score", 0] },
                  { $lte: ["$average_score", 13] },
                ],
              },
              then: "A",
            },
            {
              case: {
                $and: [
                  { $gte: ["$average_score", 14] },
                  { $lte: ["$average_score", 27] },
                ],
              },
              then: "B",
            },
            { case: { $gte: ["$average_score", 28] }, then: "C" },
          ],
          default: null,
        },
      },
    },
  },
]);
