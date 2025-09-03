CREATE TABLE game_platforms (
  id VARCHAR(36) PRIMARY KEY,
  game_id VARCHAR(36) NOT NULL REFERENCES games (id),
  platform_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE INDEX idx_game_platforms_platform_name ON game_platforms (platform_name);
