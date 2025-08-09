SELECT
	p.index,
	p.name,
	round(r0.Value * 304.8, 2) as elevation,
  p.project_name,
FROM
	denorm_entities AS p
	JOIN denorm_string_params AS r2 ON r2.Entity = p.index
	AND r2.Name <> 'TypeIfcGUID' -- Exclude 'TypeIfcGUID' from the joined results
	LEFT JOIN denorm_double_params AS r0 ON r0.Entity = p.index
WHERE
	p.category LIKE 'Levels'
	AND r0.Name LIKE 'Elevation'
GROUP BY
	p.name,
	p.index,
	p.project_name,
	r0.Value
ORDER BY
	r0.Value DESC
