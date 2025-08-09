CREATE
OR REPLACE VIEW def_wall_build_up AS
SELECT
	e1.index AS entity_index,
	rls1.EntityB AS def_index,
	e2.category AS def_category,
	e2.Name AS def_value,
	str1.String AS param_category,
	dp.Value AS param_value,
	rls2.EntityB AS material_index,
	e3.Name AS material_name
FROM
	denorm_entities AS e1
	LEFT OUTER JOIN Relations AS rls1 ON e1.index = rls1.EntityA
	LEFT OUTER JOIN denorm_entities AS e2 ON e2.index = rls1.EntityB
	LEFT OUTER JOIN DoubleParameters AS dp ON dp.Entity = rls1.EntityB
	LEFT OUTER JOIN Descriptors AS dsp ON dsp."index" = dp.Descriptor
	LEFT OUTER JOIN Strings AS str1 ON str1."index" = dsp.Name
	LEFT OUTER JOIN Relations AS rls2 ON rls2.EntityA = rls1.EntityB
	LEFT OUTER JOIN denorm_entities AS e3 ON e3.index = rls2.EntityB
WHERE
	e1.category LIKE 'Walls'
	AND rls1.RelationType = 6
ORDER BY
	e1.index;

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

CREATE OR REPLACE view def_wall_family 
AS SELECT 
  e.index,
  v.name as value,
  v.index as wall_build_up_index,
FROM
  elem_wall AS e
  LEFT OUTER JOIN EntityParameters AS ep ON ep.Entity = e.index 
  LEFT OUTER JOIN denorm_descriptors AS dsp ON dsp."index" = ep.Descriptor
  LEFT OUTER JOIN denorm_entities AS v ON v."index" = ep.Value
WHERE 
dsp.Name LIKE 'Family and Type'
ORDER BY
  wall_build_up_index;	

-- accm_wall_build_up
CREATE OR REPLACE view accm_wall_build_up
AS SELECT
	entity_index,
  FIRST(e.name) AS family_name,
  LIST (def_value) AS names,
  LIST (material_name) AS materials,
  LIST (round(param_value * 304.8, 1)) AS thicknesses,
  LIST (def_category)AS categories,
  round(SUM(param_value * 304.8), 1) AS total_thickness,
  
FROM
	def_wall_build_up
  LEFT OUTER JOIN denorm_entities AS e ON e."index" = entity_index
GROUP BY
	entity_index
ORDER BY
	entity_index;

CREATE OR REPLACE VIEW accm_wall_area
AS SELECT
	entity_index,
	FIRST (e.name) AS family_name,

	LIST (DISTINCT wf.index),
	round(SUM(dp1.Value * 0.09290304), 1) AS total_area
FROM
	def_wall_build_up
	LEFT OUTER JOIN denorm_entities AS e ON e."index" = entity_index
	LEFT OUTER JOIN def_wall_family AS wf ON wf.wall_build_up_index = entity_index
	LEFT OUTER JOIN def_wall_double_params AS dp1 ON dp1.index = wf.index
WHERE
	dp1.Name LIKE 'Area'
GROUP BY
	entity_index,
ORDER BY
	entity_index ;
