SELECT
  paramName.String AS paramName,
  COUNT(*) AS count
FROM
  denorm_entities AS e
LEFT OUTER JOIN
  EntityParameters AS ep
  ON e.index = ep.Entity
LEFT OUTER JOIN
  denorm_entities AS e2 
  ON e2.index = ep.Value
LEFT OUTER JOIN
  Descriptors AS dsp
  ON dsp."index" = ep.Descriptor
LEFT OUTER JOIN
  Strings AS paramName
  ON paramName.index = dsp.Name
WHERE
  e.category LIKE 'Walls'
GROUP BY
  paramName.String
ORDER BY

-- select * from denorm_entities where category like '%Tags';
 SELECT 
--	e1.LocalId,
--	e1.GlobalId,
e1.category,
	e1.index,
	e1.name,
	e1.project_name,
	e1.path_name,
  ep1, dsp
FROM
	denorm_entities AS e1
	RIGHT OUTER JOIN denorm_points_params AS ep1 ON ep1.Entity = e1.index
  LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep1.Descriptor

WHERE
e1.category LIKE '%Tags'
ORDER BY
	e1.index; paramName.String;
