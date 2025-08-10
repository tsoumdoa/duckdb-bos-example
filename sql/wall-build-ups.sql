SELECT
    e1.index AS entity_index,
    FIRST(e1.name) AS family_name,
    LIST(e2.Name) AS names,
    LIST(e3.Name) AS materials,
    LIST(ROUND(dp.Value * 304.8, 1)) AS thicknesses,
    LIST(e2.category) AS categories,
    ROUND(SUM(dp.Value * 304.8), 1) AS total_thickness
FROM denorm_entities AS e1
LEFT JOIN Relations AS rls1
    ON e1.index = rls1.EntityA
LEFT JOIN denorm_entities AS e2
    ON e2.index = rls1.EntityB
LEFT JOIN DoubleParameters AS dp
    ON dp.Entity = rls1.EntityB
LEFT JOIN Descriptors AS dsp
    ON dsp.index = dp.Descriptor
LEFT JOIN Strings AS str1
    ON str1.index = dsp.Name
LEFT JOIN Relations AS rls2
    ON rls2.EntityA = rls1.EntityB
LEFT JOIN denorm_entities AS e3
    ON e3.index = rls2.EntityB
WHERE e1.category LIKE 'Walls'
  AND rls1.RelationType = 6
GROUP BY e1.index
ORDER BY e1.index;
