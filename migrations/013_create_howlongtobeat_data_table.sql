CREATE TABLE howlongtobeat_data (
  id VARCHAR(36) PRIMARY KEY,
  game_id VARCHAR(36) NOT NULL REFERENCES games (id),
  hltb_id BIGINT NOT NULL,
  main_story TEXT NOT NULL,
  main_story_sides TEXT NOT NULL,
  completionist TEXT NOT NULL,
  main_story_hours NUMERIC(6, 2),
  main_story_sides_hours NUMERIC(6, 2),
  completionist_hours NUMERIC(6, 2),
  created_at TIMESTAMP NOT NULL DEFAULT NOW (),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW ()
);

CREATE INDEX idx_howlongtobeat_data_hltb_id ON howlongtobeat_data (hltb_id);

CREATE INDEX idx_howlongtobeat_data_main_story_hours ON howlongtobeat_data (main_story_hours);

CREATE INDEX idx_howlongtobeat_data_main_story_sides_hours ON howlongtobeat_data (main_story_sides_hours);

CREATE INDEX idx_howlongtobeat_data_completionist_hours ON howlongtobeat_data (completionist_hours);
