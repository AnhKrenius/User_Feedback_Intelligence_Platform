WITH internal_week AS (
  SELECT
    date_trunc('week', date::date) AS week,
    avg(active_users)::bigint AS avg_active_users,
    avg(session_count)::bigint AS avg_sessions,
    avg(avg_session_duration)::numeric(10, 2) AS avg_visit_minutes
  FROM demo_internal_daily
  GROUP BY 1
),
voice_week AS (
  SELECT
    date_trunc('week', to_timestamp(created_utc) AT TIME ZONE 'UTC') AS week,
    count(*) AS submission_count,
    avg((sentiment_advanced = 'negative')::int)::numeric(8, 4) AS post_critical_rate
  FROM submissions
  GROUP BY 1
)
SELECT
  i.week,
  i.avg_active_users,
  i.avg_sessions,
  i.avg_visit_minutes,
  v.submission_count,
  v.post_critical_rate
FROM internal_week i
LEFT JOIN voice_week v USING (week)
ORDER BY i.week;
