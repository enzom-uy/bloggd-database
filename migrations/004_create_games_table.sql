CREATE TABLE games (
  id VARCHAR(36) PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  release_date DATE,
  cover_url TEXT,
  developer VARCHAR(255),
  publisher VARCHAR(255),
  igdb_id BIGINT,
  created_at TIMESTAMP DEFAULT NOW (),
  updated_at TIMESTAMP
);

CREATE INDEX idx_games_title ON games (title);

CREATE INDEX idx_games_igdb_id ON games (igdb_id);
