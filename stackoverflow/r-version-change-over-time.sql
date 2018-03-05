#standardSQL
SELECT
  `Posts`.`creation_date`, 
  TIMESTAMP_TRUNC(`Posts`.`creation_date`, MONTH) AS `year_month`,
	REGEXP_EXTRACT(`Posts`.`body`, r"R [v|V]ersion ([0-9\\.]+) \([0-9-]+\)") AS `r_version`
FROM
  `bigquery-public-data.stackoverflow.posts_questions` AS `Posts`
WHERE
  REGEXP_CONTAINS(`Posts`.`tags`, "[^|\\|]r[$|\\|]")
ORDER BY
	`Posts`.`creation_date`;

