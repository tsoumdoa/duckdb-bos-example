-- get count by category
SELECT
  e.category AS paramname,
  COUNT(*) AS count
FROM
  denorm_entities AS e
  LEFT OUTER JOIN
    entityparameters AS ep
    ON e.index = ep.entity
  LEFT OUTER JOIN
    denorm_entities AS e2
    ON ep.value = e2.index
  LEFT OUTER JOIN
    descriptors AS dsp
    ON ep.descriptor = dsp.index
  LEFT OUTER JOIN
    strings AS paramname
    ON dsp.name = paramname.index

GROUP BY
  e.category
ORDER BY count DESC;

-- select * from denorm_entities where category like '%Tags';
SELECT
--	e1.LocalId,
--	e1.GlobalId,
  e1.category,
  e1.index,
  e1.name,
  e1.project_name,
  e1.path_name,
  ep1,
  dsp
FROM
  denorm_entities AS e1
  RIGHT OUTER JOIN denorm_points_params AS ep1 ON e1.index = ep1.entity
  LEFT OUTER JOIN denorm_descriptors AS dsp ON ep1.descriptor = dsp.index

WHERE
  e1.category LIKE '%Tags'
ORDER BY
  e1.index;
