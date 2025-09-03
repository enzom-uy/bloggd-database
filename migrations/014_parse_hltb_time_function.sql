CREATE OR REPLACE FUNCTION parse_hltb_time(time_text TEXT) 
RETURNS NUMERIC AS $$
DECLARE
    result NUMERIC;
    clean_text TEXT;
    base_number TEXT;
BEGIN
    -- Handle NULL, empty, or special cases
    IF time_text IS NULL OR LENGTH(trim(time_text)) = 0 THEN
        RETURN NULL;
    END IF;
    
    -- Handle special HLTB cases
    time_text := LOWER(trim(time_text));
    
    -- Common HLTB special values
    IF time_text IN ('--', '-', 'n/a', 'na', 'tbd', 'unknown') THEN
        RETURN NULL;
    END IF;
    
    -- Handle ranges like "25-30 Hours" -> take average
    IF time_text ~ '[0-9]+-[0-9]+' THEN
        DECLARE
            first_num NUMERIC;
            second_num NUMERIC;
            range_match TEXT[];
        BEGIN
            range_match := regexp_matches(time_text, '([0-9]+)-([0-9]+)');
            first_num := range_match[1]::NUMERIC;
            second_num := range_match[2]::NUMERIC;
            RETURN (first_num + second_num) / 2.0;
        END;
    END IF;
    
    -- Handle common fractions (optimized order by frequency)
    IF time_text LIKE '%½%' THEN
        base_number := REGEXP_REPLACE(time_text, '[^0-9]', '', 'g');
        IF LENGTH(base_number) > 0 THEN
            RETURN base_number::NUMERIC + 0.5;
        ELSE
            RETURN 0.5;
        END IF;
    ELSIF time_text LIKE '%¼%' THEN
        base_number := REGEXP_REPLACE(time_text, '[^0-9]', '', 'g');
        IF LENGTH(base_number) > 0 THEN
            RETURN base_number::NUMERIC + 0.25;
        ELSE
            RETURN 0.25;
        END IF;
    ELSIF time_text LIKE '%¾%' THEN
        base_number := REGEXP_REPLACE(time_text, '[^0-9]', '', 'g');
        IF LENGTH(base_number) > 0 THEN
            RETURN base_number::NUMERIC + 0.75;
        ELSE
            RETURN 0.75;
        END IF;
    ELSIF time_text LIKE '%⅓%' THEN
        base_number := REGEXP_REPLACE(time_text, '[^0-9]', '', 'g');
        IF LENGTH(base_number) > 0 THEN
            RETURN base_number::NUMERIC + 0.33;
        ELSE
            RETURN 0.33;
        END IF;
    ELSIF time_text LIKE '%⅔%' THEN
        base_number := REGEXP_REPLACE(time_text, '[^0-9]', '', 'g');
        IF LENGTH(base_number) > 0 THEN
            RETURN base_number::NUMERIC + 0.67;
        ELSE
            RETURN 0.67;
        END IF;
    END IF;
    
    -- Handle decimal numbers like "28.5 Hours"
    IF time_text ~ '[0-9]+\.[0-9]+' THEN
        clean_text := REGEXP_REPLACE(time_text, '[^0-9.]', '', 'g');
        BEGIN
            RETURN clean_text::NUMERIC;
        EXCEPTION
            WHEN OTHERS THEN RETURN NULL;
        END;
    END IF;
    
    -- Handle simple integers like "42 Hours"
    clean_text := REGEXP_REPLACE(time_text, '[^0-9]', '', 'g');
    IF LENGTH(clean_text) > 0 THEN
        BEGIN
            RETURN clean_text::NUMERIC;
        EXCEPTION
            WHEN OTHERS THEN RETURN NULL;
        END;
    END IF;
    
    -- If nothing matches, return NULL
    RETURN NULL;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
