-- .read ../../sql/init.sql
-- list all levels	
SELECT
	p.index,
	p.name,
	round(r0.Value * 304.8, 0) AS elevation,
	p.project_name,
FROM
	denorm_entities AS p
	JOIN denorm_string_params AS r2 ON r2.Entity = p.index
	JOIN denorm_double_params AS r0 ON r0.Entity = p.index
WHERE
	p.category LIKE 'Levels'
	AND r0.Name LIKE 'Elevation'
GROUP BY
	p.name,
	p.index,
	p.project_name,
	r0.Value
ORDER BY
	r0.Value DESC;

-- List all the grids 
SELECT
    e.index,
    e.name,
    dp2.Strings AS grid_type,
    CASE
        WHEN MAX(CASE WHEN dp1.Name = 'rvt:Grid:StartPoint' 
                      THEN ROUND(dp1.X * 304.8, 0) END)
           = MAX(CASE WHEN dp1.Name = 'rvt:Grid:EndPoint' 
                      THEN ROUND(dp1.X * 304.8, 0) END)
        THEN 'y'
        WHEN MAX(CASE WHEN dp1.Name = 'rvt:Grid:StartPoint' 
                      THEN ROUND(dp1.Y * 304.8, 0) END)
           = MAX(CASE WHEN dp1.Name = 'rvt:Grid:EndPoint' 
                      THEN ROUND(dp1.Y * 304.8, 0) END)
        THEN 'x'
        ELSE 'diagonal'
    END AS grid_dir,
    
    MAX(CASE WHEN dp1.Name = 'rvt:Grid:StartPoint' THEN round(dp1.X * 304.8, 0) END) AS start_x,
    MAX(CASE WHEN dp1.Name = 'rvt:Grid:StartPoint' THEN round(dp1.Y * 304.8, 0) END) AS start_y,
    MAX(CASE WHEN dp1.Name = 'rvt:Grid:EndPoint' THEN round(dp1.X * 304.8, 0) END) AS end_x,
    MAX(CASE WHEN dp1.Name = 'rvt:Grid:EndPoint' THEN round(dp1.Y * 304.8, 0) END) AS end_y,

    MAX(CASE WHEN dp1.Name = 'rvt:Grid:CenterPoint' THEN round(dp1.X * 304.8, 0) END) AS center_x,
    MAX(CASE WHEN dp1.Name = 'rvt:Grid:CenterPoint' THEN round(dp1.Y * 304.8, 0) END) AS center_y,
    MAX(CASE WHEN dp1.Name = 'rvt:Grid:CenterPoint' THEN round(dp3.Value * 304.8, 0) END) AS arc_radius,

    e.project_name,
FROM
    denorm_entities AS e
    JOIN denorm_points_params AS dp1 ON dp1.Entity = e.index
    JOIN denorm_string_params AS dp2 ON dp2.Entity = e.index
    LEFT JOIN denorm_double_params AS dp3 ON dp3.Entity = e.index
WHERE
    e.category LIKE 'Grids'
    AND dp2.Name LIKE 'rvt:Grid:Type'
GROUP BY
    e.index,
    e.name,
    dp2.Strings,
    e.project_name
ORDER BY
    e.Name;

