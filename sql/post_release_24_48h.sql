WITH anchor AS (
  SELECT
    r.release_date::date AS release_date,
    r.release_type,
    r.feature_area,
    s.id AS submission_id,
    t.thread_bucket,
    to_timestamp(s.created_utc) AT TIME ZONE 'UTC' AS post_time_utc
  FROM demo_release_events r
  JOIN submissions s
    ON to_timestamp(s.created_utc) AT TIME ZONE 'UTC' >= (r.release_date::timestamp AT TIME ZONE 'UTC' + interval '24 hours')
   AND to_timestamp(s.created_utc) AT TIME ZONE 'UTC' <  (r.release_date::timestamp AT TIME ZONE 'UTC' + interval '48 hours')
  JOIN threads t ON t.submission_id = s.id
)
SELECT
  release_date,
  release_type,
  feature_area,
  count(*) FILTER (WHERE thread_bucket = 'negative') AS negative_threads_24_48h,
  count(*) AS threads_in_window
FROM anchor
GROUP BY 1, 2, 3
ORDER BY release_date DESC;
