CREATE TABLE game_genres (
  id VARCHAR(36) PRIMARY KEY,
  game_id VARCHAR(36) NOT NULL REFERENCES games (id),
  genre_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE INDEX idx_game_genres_genre_name ON game_genres (genre_name);
