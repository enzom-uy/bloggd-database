CREATE TYPE user_game_status AS ENUM ('backlog', 'playing', 'played', 'dropped');

CREATE TABLE user_games (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  game_id VARCHAR(36) NOT NULL,
  status user_game_status NOT NULL,
  rating DECIMAL(2, 1),
  created_at TIMESTAMP DEFAULT NOW (),
  updated_at TIMESTAMP
);

CREATE INDEX idx_user_games_status on user_games (status);

CREATE INDEX idx_user_games_rating on user_games (rating);
