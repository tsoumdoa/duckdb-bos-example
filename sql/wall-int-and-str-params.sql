SELECT
  e.index,
  e.name,
  p1
FROM
  denorm_entities AS e
  INNER JOIN denorm_points_params AS p0 ON e.index = p0.entity
  INNER JOIN denorm_int_params AS p1 ON e.index = p1.entity
WHERE
  e.category LIKE 'Walls'
-- GROUP BY index, name
ORDER BY index
--ORDER BY unconnected_height DESC;
