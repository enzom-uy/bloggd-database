CREATE OR REPLACE FUNCTION update_hltb_numeric_columns()
RETURNS TRIGGER AS $$
BEGIN
    -- Auto-calculate numeric values from text columns
    NEW.main_story_hours := parse_hltb_time(NEW.main_story);
    NEW.main_story_sides_hours := parse_hltb_time(NEW.main_story_sides);
    NEW.completionist_hours := parse_hltb_time(NEW.completionist);
    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER trigger_update_hltb_numeric_columns
    BEFORE INSERT OR UPDATE ON howlongtobeat_data
    FOR EACH ROW
    EXECUTE FUNCTION update_hltb_numeric_columns();
