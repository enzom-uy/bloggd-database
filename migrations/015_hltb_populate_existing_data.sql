UPDATE howlongtobeat_data
SET
  main_story_hours = parse_hltb_time (main_story),
  main_story_sides_hours = parse_hltb_time (main_story_sides),
  completionist_hours = parse_hltb_time (completionist),
  updated_at = NOW ()
WHERE
  main_story IS NOT NULL
  OR main_story_sides IS NOT NULL
  OR completionist IS NOT NULL;
