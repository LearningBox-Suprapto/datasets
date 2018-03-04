#standardSQL
SELECT
  t1.year_month,
  t1.r_version,
  COUNT(t1.r_version) AS n
FROM (
  SELECT
    TIMESTAMP_TRUNC(Posts.creation_date, MONTH) AS `year_month`,
    REGEXP_EXTRACT(Posts.body, r"R [v|V]ersion ([0-9\\.]+) \([0-9-]+\)") AS `r_version`
  FROM
    `bigquery-public-data.stackoverflow.posts_questions` AS Posts
  WHERE
    REGEXP_CONTAINS(Posts.body, "R [v|V]ersion [0-9\\.]+ \\([0-9-]+\\)")
  ORDER BY
    Posts.creation_date) AS t1
GROUP BY
  t1.year_month,
  t1.r_version
ORDER BY
  t1.year_month,
  t1.r_version;
