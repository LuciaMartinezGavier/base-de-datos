// -------------- MONGO DB --------------------- //

// Para correr, ir al directorio con todos los archivos
// de datos de la base mongo. 
// y correr
//  sudo docker start mongo-labs
// $ mongo --host 172.17.0.2


// Insertar 5 nuevos usuarios en la colección users. 
// Para cada nuevo usuario creado, insertar al menos un 
// comentario realizado por el usuario en la colección 
//comments.

db.collection.insertMany([
  {
    "name" : "álvaro",
    "email" : "alvaro@yahoo.com",
    "password" : "si"
  },
  {
    "name" : "Bruno",
    "email" : "bruno@yahoo.com",
    "password" : "no"
  },
  {
    "name" : "Anna",
    "email" : "anna@yahoo.com",
    "password" : "no sé"
  },
  {
    "name" : "Leo",
    "email" : "leo@yahoo.com",
    "password" : "casi"
  },
  {
    "name" : "Cesco",
    "email" : "cesco@yahoo.com",
    "password" : "siempre"
  }
]);

// Listar el título, año, actores (cast), directores y 
// rating de las 10 películas con mayor rating (“imdb.
// rating”) de la década del 90. ¿Cuál es el valor del 
// rating de la película que tiene mayor rating? (Hint: 
// Chequear que el valor de “imdb.rating” sea de tipo
// “double”).

db.movies.find(
  {
    "year": { $gt: 1990, $lt: 2000},

  }, {
    "title": true,
    "year": true,
    "cast": true,
    "directors": true, 
    "imdb.rating": true
  }
).sort({"imdb.rating": 1}).limit(10);


// Listar el nombre, email, texto y fecha de los 
// comentarios que la película con id (movie_id) ObjectId
// ("573a1399f29313caabcee886") recibió entre los años 
//2014 y 2016 inclusive. Listar ordenados por fecha. 
// Escribir una nueva consulta (modificando la anterior) 
// para responder ¿Cuántos comentarios recibió?
db.comments.find(
  {
    "movie_id": ObjectId("573a1399f29313caabcee886"),
    "date": {$gt: ISODate("2013-12-31"), $lt: ISODate("2017-01-01") }
  }, 
  {
    "name": true,
    "email": true,
    "text": true,
    "date": true
  }
).sort({"date": 1});

// Listar el nombre, id de la película, texto y fecha de 
// los 3 comentarios más recientes realizados por el 
// usuario con email patricia_good@fakegmail.com. 

db.comments.find(
 {
  "email": "patricia_good@fakegmail.com",
 },
 {
  "name": true,
  "movie_id": true,
  "text": true,
  "date": true, 
 } 
).sort({"date": 1}).limit(3);

// Listar el título, idiomas (languages), géneros, fecha 
// de lanzamiento (released) y número de votos (“imdb.
// votes”) de las películas de géneros Drama y Action 
// (la película puede tener otros géneros adicionales), 
// que solo están disponibles en un único idioma y por 
// último tengan un rating (“imdb.rating”) mayor a 9 o 
// bien tengan una duración (runtime) de al menos 180 
// minutos. Listar ordenados por fecha de lanzamiento y 
// número de votos.

db.movies.find(
  {
    "genres": { $all: ["Drama", "Action"] },
    "languages": { $size: 1},
    $or: [
      {"imdb.rating": {$gt: 9}},
      {"runtime": {$gte: 180}}
    ],
  },
  {
    "_id": 0,
    "title": 1,
    "languages": 1,
    "genres": 1,
    "released": 1,
    "imdb.votes": 1,
  }
).sort({"released": 1, "imdb.votes": 1});


// Listar el id del teatro (theaterId), estado (“location.address.state”),
// ciudad (“location.address.city”), y coordenadas (“location.geo.coordinates”) 
// de los teatros que se encuentran en algunos de los estados "CA", "NY", "TX" y 
// el nombre de la ciudades comienza con una ‘F’. Listar ordenados por estado y
//  ciudad.

db.theaters.find(
  {
    "location.address.state": {$in: ["CA", "NY", "TX"]},
    "location.address.city": {$regex: /^F.*/}
  },
  {
    "_id": 0,
    "theaterId": 1,
    "location.address.state": 1,
    "location.address.city": 1,
    "location.geo.coordinates": 1,
  }
).sort({
  "location.address.state": 1,
  "location.address.city": 1
}).pretty()

// Actualizar los valores de los campos texto (text) y fecha (date) del
// comentario cuyo id es ObjectId("5b72236520a3277c015b3b73") a "mi mejor 
// comentario" y fecha actual respectivamente.

db.comments.update(
  {
    "_id" : ObjectId("5b72236520a3277c015b3b73")
  },
  {
    $set: {
      "text" : "mi mejor comentario",
      // new Date() returns the current date as a Date object. 
      // mongosh wraps the Date object with the ISODate helper. 
      // The ISODate is in UTC.
      "date": new Date(), 
    }
  }
);

// Actualizar el valor de la contraseña del usuario cuyo email es
//  joel.macdonel@fakegmail.com a "some password". La misma consulta debe poder
//  insertar un nuevo usuario en caso que el usuario no exista. Ejecute la 
// consulta dos veces. ¿Qué operación se realiza en cada caso? 
// (Hint: usar upserts). 

db.users.update(
  {
    "email": "joel.macdonel@fakegmail.com",
  },
  {
    $set: { "password": "some password" }
  },
  {
    upsert: true,
  }
);

// Remover todos los comentarios realizados por el usuario cuyo email 
// es victor_patel@fakegmail.com durante el año 1980.

db.comments.deleteMany({
  "email": "victor_patel@fakegmail.com",
  "date": {$gt: ISODate("1979-12-31"), $lt: ISODate("1981-01-01") }
})

// Listar el id del restaurante (restaurant_id) y las calificaciones de los 
// restaurantes donde al menos una de sus calificaciones haya sido realizada 
// entre 2014 y 2015 inclusive, y que tenga una puntuación (score)
//  mayor a 70 y menor o igual a 90.
db.restaurants.find(
  {
    "grades": {
      $elemMatch: {
        "score": {$gt: 70, $lte: 90},
        "date": {$gt: ISODate("2013-12-31"), $lt: ISODate("2016-01-01") }
      }
    }
  },
  {
    "_id": 0,
    "restaurant_id": 1,
    "grades": 1, 
  }
).pretty()

// Agregar dos nuevas calificaciones al restaurante cuyo id es "50018608".
//  A continuación se especifican las calificaciones a agregar en
//  una sola consulta.  
db.restaurants.update(
  {
    "restaurant_id": "50018608",
  },
  {
    $push: {
      "grades": {
        $each: [
          {
            "date" : ISODate("2019-10-10T00:00:00Z"),
            "grade" : "A",
            "score" : 18
          },
          {
            "date" : ISODate("2020-02-25T00:00:00Z"),
            "grade" : "A",
            "score" : 21
          }
        ]
      }
    }
  }
)
