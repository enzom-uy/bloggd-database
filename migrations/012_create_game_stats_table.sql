CREATE TABLE game_stats (
  game_id VARCHAR(36) PRIMARY KEY REFERENCES games (id),
  avg_rating DECIMAL(3, 2),
  reviews_count INT,
  backlog_count INT,
  playing_count INT,
  played_count INT,
  dropped_count INT
);
