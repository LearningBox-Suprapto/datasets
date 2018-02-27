-- Top 5 Tags (with overall posts)

DECLARE @n_tags int;
DECLARE @n_posts int;

SET @n_tags = 5;
SET @n_posts = 5;

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
        TOP (@n_tags) Tags.Id
      FROM 
        Tags
      ORDER BY 
        Tags.Count DESC)) AS PostRanks
LEFT JOIN
  Posts
ON Posts.Id = PostRanks.Id
WHERE 
  n <= @n_posts
ORDER BY
  PostRanks.TagId, 
  PostRanks.Score DESC;

