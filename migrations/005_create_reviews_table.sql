CREATE TABLE reviews (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  game_id VARCHAR(36) NOT NULL,
  body TEXT,
  rating DECIMAL(2, 1) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW (),
  updated_at TIMESTAMP
)
