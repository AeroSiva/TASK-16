CREATE DATABASE imdb;
USE imdb;
CREATE TABLE movie (
	movie_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    movie_name VARCHAR(100)  NOT NULL
    );
INSERT INTO movie (movie_name)VALUES
	("movie 1"),("movie 2"), ("movie 3"),("movie 4"), ("movie 5")
;
CREATE TABLE genre (
	genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(100)
    );
INSERT INTO genre (genre_name)VALUES
	("Romance"),("comedy"),("Action"),("Thriller"),("Science-fiction")
;
CREATE TABLE movie_genre(
	movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    CONSTRAINT fk_movie FOREIGN KEY(movie_id) REFERENCES movie(movie_id),
    CONSTRAINT fk_genre FOREIGN KEY(genre_id) REFERENCES genre(genre_id)
);

INSERT INTO movie_genre VALUES
(1,1),(1,2),(1,4),
(2,1),(2,2),(2,5),
(3,1),(3,5),
(4,4),(4,3),
(5,1),(5,3);

SELECT
	movie.movie_id,
	movie.movie_name,
	GROUP_CONCAT(genre.genre_name ORDER BY genre.genre_name) as GENRES
FROM
	movie
JOIN
	movie_genre ON movie_genre.movie_id = movie.movie_id
JOIN 
	genre ON genre.genre_id = movie_genre.genre_id
GROUP BY
	movie.movie_id,movie.movie_name;
DROP TABLE media;

CREATE TABLE media(
	media_id INT AUTO_INCREMENT PRIMARY KEY,
    media_name VARCHAR(50)
);
INSERT INTO media(media_name) VALUES
	("mp3"),("jpeg"),("mp4");

CREATE TABLE movie_media(
	movie_id INT,
    media_id INT,
    PRIMARY KEY (movie_id, media_id),
    CONSTRAINT fk_movie1 FOREIGN KEY(movie_id) REFERENCES movie(movie_id),
    CONSTRAINT fk_media FOREIGN KEY(media_id) REFERENCES media(media_id)
);
INSERT INTO movie_media VALUES
	(1,1),(1,2),(1,3),
    (2,1),(2,3),
    (3,1),(3,3),
    (4,1),(4,2),
    (5,2),(5,3);
SELECT
	movie.movie_id,
	movie.movie_name,
	GROUP_CONCAT(media.media_name ORDER BY media.media_name) as MEDIAS
    
FROM
	movie
JOIN
	movie_media ON movie_media.movie_id = movie.movie_id
JOIN 
	media ON media.media_id = movie_media.media_id
GROUP BY
	movie.movie_id,movie.movie_name
;
CREATE TABLE users(
	user_id INT AUTO_INCREMENT PRIMARY KEY,
	user_name VARCHAR(50)
);

INSERT INTO users(user_name) VALUES("user 1"),("user 2"),("user 3");

CREATE TABLE review(
	review_id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
    movie_id INT,
    CONSTRAINT fk_movie2 FOREIGN KEY(movie_id) REFERENCES movie(movie_id),
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(user_id),
    review TEXT
);

INSERT INTO review(user_id,movie_id,review) VALUES
	(1,1,"IT IS A VERY GOOD MOVIE"),
    (1,2,"IT IS A GOOD MOVIE"),
    (1,5,"IT IS A VERY GOOD MOVIE"),
    (2,3,"IT IS A MUST WATCH MOVIE"),
    (2,5,"IT IS ONETIME WATCJHABLE MOVIE"),
    (3,4,"IT IS A FANTASTIC MOVIE"),
    (3,2,"IT IS A AWARD WORTH MOVIE")
    ;
SELECT
    movie.movie_name,
    GROUP_CONCAT(CONCAT(users.user_name, ': ', review.review) SEPARATOR '\n') AS Users_Reviews
FROM
    movie
JOIN
    review ON review.movie_id = movie.movie_id
JOIN 
    users ON users.user_id = review.user_id
GROUP BY
    movie.movie_name;



CREATE TABLE artist(
artist_id INT AUTO_INCREMENT PRIMARY KEY,
artist_name VARCHAR(100)
);

INSERT INTO artist(artist_name) VALUES("ARTIST 1"),("ARTIST 2"),("ARTIST 3"),("ARTIST 4");

CREATE TABLE skills(
skill_id INT AUTO_INCREMENT PRIMARY KEY,
skill_name VARCHAR(100));

INSERT INTO skills(skill_name) VALUES("SKILL 1"),("SKILL 2"),("SKILL 3");

CREATE TABLE artist_skill(
	artist_id INT,
    skilL_id INT,
    CONSTRAINT FK_artist FOREIGN KEY(artist_id) REFERENCES artist(artist_id),
    CONSTRAINT FK_skill FOREIGN KEY(skill_id) REFERENCES skills(skill_id)
);

INSERT INTO artist_skill VALUES
	(1,1),(1,2),(1,3),
    (2,2),(2,3),
    (3,1),(3,3),
    (4,2),(4,1);
    
SELECT
	artist.artist_name,
    GROUP_CONCAT(skills.skill_name ORDER BY skills.skill_id) AS SKILLS
FROM
	artist
JOIN
	artist_skill ON artist.artist_id = artist_skill.artist_id
JOIN
	skills ON skills.skill_id = artist_skill.skill_id
GROUP BY
	artist.artist_id;
    
CREATE TABLE roles(
	role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(100)
    );
INSERT INTO roles(role_name) VALUES
	("role 1"),("role 2"),("role 3"),("role 4"),("role 5"),
    ("role 6"),("role 7");

CREATE TABLE artist_role(
	artist_id INT,
    movie_id INT,
    role_id INT,
    CONSTRAINT FK_artist1 FOREIGN KEY(artist_id) REFERENCES artist(artist_id),
    CONSTRAINT FK_role FOREIGN KEY(role_id) REFERENCES roles(role_id),
    CONSTRAINT FK_movie3 FOREIGN KEY(movie_id) REFERENCES movie(movie_id)
);

INSERT INTO artist_role VALUES
	(1,1,1),(1,1,5),
    (2,2,2),
    (3,3,3),(3,4,6),
    (4,4,4),(4,5,7);

SELECT
	movie.movie_name,
    GROUP_CONCAT(CONCAT(artist.artist_name, ':',roles.role_name) SEPARATOR '\n')
FROM
	movie
JOIN
	artist_role ON artist_role.movie_id = movie.movie_id
JOIN
	artist ON artist.artist_id = artist_role.artist_id
JOIN
	roles ON roles.role_id = artist_role.role_id
GROUP BY 
	movie.movie_name
;