CREATE TABLE collections (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  title VARCHAR(255) NOT NULL DEFAULT 'Untitled collection',
  description VARCHAR(255),
  is_public BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW () NOT NULL,
  updated_at TIMESTAMP,
  CONSTRAINT fk_collections_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);
