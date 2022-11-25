-- Nota: 9.6

-- EJERCICIO 1
CREATE TABLE reviews (
        id int NOT NULL AUTO_INCREMENT,
        user int NOT NULL,
        game int NOT NULL,
        rating DECIMAL(2, 1) NOT NULL,
        comment varchar(250),

        PRIMARY KEY (id),
        CONSTRAINT reviews_users_fk FOREIGN KEY (user) REFERENCES user(id),
        CONSTRAINT reviews_games_fk FOREIGN KEY (game) REFERENCES game(id),
        UNIQUE KEY (user, game)
);

-- Comentario: En el ejercicio (1) no se especifica que deba ponerse el 
-- campo id, pero para seguir con el esquema provisto lo agregué como
-- primary key. También podría ser clave primaria (user, game) ya que 
-- esta es única. 

-- EJERCICIO 2
DELETE FROM reviews
WHERE reviews.comment IS NULL;

ALTER TABLE reviews
MODIFY comment VARCHAR(250) NOT NULL;

-- EJERCICIO 3
WITH avg_rating_genre AS (

    SELECT
        genre.name,
        rating_genre.avg_rating
    FROM genre
    INNER JOIN (
        SELECT 
            AVG(reviews.rating) AS "avg_rating",
            game_genres.genre as "genre"
        FROM reviews
        INNER JOIN game_genres
        USING(game)
        GROUP BY genre
        ) rating_genre
    ON genre.id = rating_genre.genre
)
(
    SELECT
        avg_rating,
        name
    FROM avg_rating_genre
    ORDER BY avg_rating
    LIMIT 1
) UNION (
    SELECT
        avg_rating,
        name
    FROM avg_rating_genre
    ORDER BY avg_rating DESC
    LIMIT 1
) ;

-- EJERCICIO 4
ALTER TABLE user
ADD number_of_reviews INT NOT NULL DEFAULT 0;


-- EJERCICIO 5
CREATE PROCEDURE set_user_number_of_reviews (IN p_user VARCHAR(100))

    BEGIN
        DECLARE num_reviews INT;

        SELECT
            count(reviews.id) AS "reviews" 
        INTO num_reviews
        FROM user
        INNER JOIN reviews
        ON user.id = reviews.user
        WHERE user.username = p_user
        GROUP BY user.id;

        UPDATE user
        SET user.number_of_reviews = num_reviews
        WHERE user.username = p_user;

    END;

    
-- EJERCICIO 6a
CREATE TRIGGER increase_number_of_reviews
AFTER INSERT
ON reviews FOR EACH ROW
BEGIN
    UPDATE user SET number_of_reviews = number_of_reviews + 1
    WHERE user.id = NEW.user;
END;

--EJERCICIO 6b
CREATE TRIGGER decrease_number_of_reviews
AFTER DELETE
ON reviews FOR EACH ROW
BEGIN
    UPDATE user SET number_of_reviews = number_of_reviews - 1
    WHERE user.id = OLD.user;
END;


-- EJERCICIO 7 
WITH game_rating AS (
    SELECT
        game.id AS "game",
        AVG(reviews.rating) AS "avg_rating"
    FROM game
    LEFT JOIN reviews
    ON game.id = reviews.game
    GROUP BY game.id
)
SELECT
    company.name AS "Name",
    best_developers.avg_rating AS "Average Rating"
FROM company
INNER JOIN (
    SELECT 
        developers.developer AS "id",
        avg(game_rating.avg_rating) AS "avg_rating"
    FROM developers
    INNER JOIN game_rating
    USING(game)
    GROUP BY developer
    HAVING count(game_rating.game) > 50
    ORDER BY avg(game_rating.avg_rating) DESC
    LIMIT 5
    ) best_developers
USING(id);


-- EJERCICIO 8
DROP ROLE IF EXISTS moderator;
CREATE ROLE moderator;
GRANT DELETE ON videogames.reviews TO moderator;
GRANT UPDATE ON videogames.reviews.comment TO moderator;

