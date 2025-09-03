CREATE TYPE activity_type AS ENUM (
  'add_review',
  'start_game',
  'finish_game',
  'drop_game'
);

CREATE TABLE user_activity (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  game_id VARCHAR(36) NOT NULL REFERENCES games (id) ON DELETE CASCADE,
  activity_type activity_type NOT NULL,
  review_id VARCHAR(36) REFERENCES reviews (id),
  created_at TIMESTAMP NOT NULL DEFAULT NOW (),
  updated_at TIMESTAMP,
  CONSTRAINT fk_user_activity_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_user_activity_game_id FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE CASCADE,
  CONSTRAINT fk_user_activity_review_id FOREIGN KEY (review_id) REFERENCES reviews (id)
);
