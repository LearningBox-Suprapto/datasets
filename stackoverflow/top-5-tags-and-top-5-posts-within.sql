-- Top 5 Tags (with overall posts) and top 5 posts within each (by score)

SELECT
  PostRanks.Id,
  PostRanks.Score,
  PostRanks.TagId,
  Posts.Title,
  Posts.Tags
FROM (
  SELECT
    Posts.Id,
    Posts.Score,
    PostTags.TagId,
    n = ROW_NUMBER() OVER (
      PARTITION BY
        PostTags.TagId
      ORDER BY
      Posts.Score DESC)
  FROM
    PostTags
  LEFT JOIN
    Posts
  ON
    PostTags.PostId = Posts.Id
  WHERE
    PostTags.TagId IN (
      SELECT
        TOP 5 Tags.Id
      FROM
        Tags
      ORDER BY
        Tags.Count DESC)) AS PostRanks
LEFT JOIN
  Posts
ON Posts.Id = PostRanks.Id
WHERE
  n <= 5
ORDER BY
  PostRanks.TagId,
  PostRanks.Score DESC;
