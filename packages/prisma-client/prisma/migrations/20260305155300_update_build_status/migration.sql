-- Migration Added by m8jj
DROP FUNCTION IF EXISTS update_build_status;
CREATE FUNCTION update_build_status(
  build_id text,
  publish_status text
) RETURNS void AS $$
BEGIN
  UPDATE "Build"
  SET "publishStatus" = publish_status
  WHERE "id" = build_id
-- RETURN;
END;
$$ LANGUAGE plpgsql;
