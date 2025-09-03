CREATE TABLE collection_games (
  id VARCHAR(36) PRIMARY KEY,
  collection_id VARCHAR(36) NOT NULL REFERENCES collections (id),
  game_id VARCHAR(36) NOT NULL REFERENCES games (id)
)
