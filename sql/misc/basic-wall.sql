CREATE
OR REPLACE VIEW elem_wall AS
SELECT DISTINCT
	e1.LocalId,
	e1.GlobalId,
	e1.index,
	e1.name,
	e1.project_name,
	e1.path_name
FROM
	denorm_entities AS e1
	RIGHT OUTER JOIN PointParameters AS ep1 ON ep1.Entity = e1.index
WHERE
	e1.category LIKE 'Walls'
ORDER BY
	e1.index;

CREATE OR REPLACE def_family_wall AS
SELECT DISTINCT
  e.index,
  dsp.Name,
  dsp.Group,
  dsp.Type,
  v.name as value,
  v.index as value_index,
FROM
  elem_wall AS e
  LEFT OUTER JOIN EntityParameters AS ep ON ep.Entity = e.index 
  LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep.Descriptor
  LEFT OUTER JOIN denorm_entities AS v ON v."index" = ep.Value
ORDER BY
  e.index;	

CREATE
OR REPLACE VIEW def_wall_string_params AS
SELECT
	e.index,
	dsp.Name,
	dsp.Units,
	dsp.Group,
	dsp.Type,
  str.String
FROM
	elem_wall AS e
	LEFT OUTER JOIN StringParameters AS ep ON e.index = ep.Entity
	LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep.Descriptor
	LEFT OUTER JOIN Strings AS str ON str."index" = ep.Value
ORDER BY
	e.index;

CREATE
OR REPLACE VIEW def_wall_integer_params AS
SELECT
	e.index,
	dsp.Name,
	dsp.Group,
	dsp.Type,
  ep.Value
FROM
	elem_wall AS e
	LEFT OUTER JOIN IntegerParameters AS ep ON ep.Entity = e.index 
	LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep.Descriptor
ORDER BY
	e.index;

CREATE
OR REPLACE VIEW def_wall_double_params AS
SELECT
	e.index,
	dsp.Name,
	dsp.Units,
	dsp.Group,
	ep.Value
FROM
	elem_wall AS e
	LEFT OUTER JOIN DoubleParameters AS ep ON ep.Entity = e.index 
	LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep.Descriptor
ORDER BY
	e.index;


CREATE
OR REPLACE VIEW def_wall_entity_params AS
SELECT
	e."index",
  dsp.Name,
  dsp.Group,
  dsp.Type,
  v.name as value,
  v.index as value_index,
FROM
	elem_wall AS e
	LEFT OUTER JOIN EntityParameters AS ep ON ep.Entity = e.index 
  LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep.Descriptor
	LEFT OUTER JOIN denorm_entities AS v ON v."index" = ep.Value
ORDER BY
	e.index;


CREATE
OR REPLACE VIEW def_wall_points_params AS
SELECT
	e.index,
  dsp.Name,
  ep.X,
  ep.Y,
  ep.Z,
FROM
	elem_wall AS e
	LEFT OUTER JOIN denorm_points_params AS ep ON ep.Entity = e.index 
	LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep.Descriptor
ORDER BY
	e.index;	



select * from elem_wall

left outer join def_wall_build_up as df on df.index = elem_wall.index
left outer join def_wall_string_params as dsp on dsp.index = elem_wall.index
left outer join def_wall_integer_params as dip on dip.index = elem_wall.index
left outer join def_wall_entity_params as dep on dep.index = elem_wall.index
left outer join def_wall_double_params as ddp on ddp.index = elem_wall.index
left outer join def_wall_points_params as dpp on dpp.index = elem_wall.index


-- elem_wall
-- def_wall_family
-- def_wall_string_params
-- def_wall_integer_params
-- def_wall_entity_params
-- def_wall_double_params
-- def_wall_points_params

-- CREATE OR REPLACE VIEW elem_wall
-- AS SELECT e1.LocalId, e1.GlobalId, e1.index, e1.name, e1.path_name, e1.project_name
-- FROM denorm_entities as e1
-- LEFT OUTER JOIN EntityParameters as ep1
-- On ep1.Entity = e1.index
-- LEFT OUTER JOIN denorm_descriptors as dsp
-- On dsp.index = ep1.Descriptor
-- WHERE e1.category LIKE 'Walls'
-- AND dsp.Name LIKE 'Type Id'
--
-- ORDER BY
--   e1.index;
--
-- SELECT * FROM elem_CREATE
-- CREATE
-- OR REPLACE VIEW elem_wall AS
SELECT DISTINCT
	e1.LocalId,
	e1.GlobalId,
	e1.index,
	e1.name,
	e1.project_name,
	e1.path_name
FROM
	denorm_entities AS e1
	RIGHT OUTER JOIN PointParameters AS ep1 ON ep1.Entity = e1.index
WHERE
	e1.category LIKE 'Walls'
ORDER BY
	e1.index;

SELECT DISTINCT
	e1.LocalId,
	e1.GlobalId,
	e1.index,
	e1.name,
	e1.project_name,
	e1.path_name
FROM
	denorm_entities AS e1
	RIGHT OUTER JOIN PointParameters AS ep1 ON ep1.Entity = e1.index
	LEFT OUTER JOIN StringParameters AS ep ON e.index = ep.Entity
	LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep.Descriptor
	LEFT OUTER JOIN Strings AS str ON str."index" = ep.Value
WHERE
	e1.category LIKE 'Walls'
ORDER BY
	e1.index;wall;
