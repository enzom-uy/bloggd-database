CREATE TABLE users (
  id VARCHAR(36) PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  -- not null if the user is created via credentials instead of steam
  password_hash VARCHAR(255),
  steam_id VARCHAR(50),
  profile_picture_url TEXT,
  bio TEXT,
  created_at TIMESTAMP DEFAULT NOW () NOT NULL,
  updated_at TIMESTAMP
);

CREATE INDEX idx_users_username ON users (username);

CREATE INDEX idx_users_email ON users (email);
