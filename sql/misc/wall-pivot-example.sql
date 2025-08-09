SELECT
  e.index,
  MAX(CASE WHEN paramName.string = 'Unconnected Height' THEN ep.Value END) AS "Unconnected Height",
  MAX(CASE WHEN paramName.string = 'Base Offset' THEN ep.Value END) AS "Base Offset",
  MAX(CASE WHEN paramName.string = 'Top Offset' THEN ep.Value END) AS "TopOffset",
  MAX(CASE WHEN paramName.string = 'Length' THEN ep.Value END) AS "Length",
  MAX(CASE WHEN paramName.string = 'Area' THEN ep.Value END) AS "Area",
  MAX(CASE WHEN paramName.string = 'Volume' THEN ep.Value END) AS "Volume",
  MAX(CASE WHEN paramName.string = 'Top Extension Distance' THEN ep.Value END) AS "Top Extension Distance",
  MAX(CASE WHEN paramName.string = 'Base Extension Distance' THEN ep.Value END) AS "Base Extension Distance"
FROM
  denorm_entities AS e
LEFT OUTER JOIN
  DoubleParameters AS ep ON e.index = ep.Entity
LEFT OUTER JOIN
  Descriptors AS dsp ON dsp."index" = ep.Descriptor
LEFT OUTER JOIN
  Strings AS paramName ON paramName.index = dsp.Name
WHERE
  e.category LIKE 'Walls' 
  AND paramName.string IN (
    'Unconnected Height',
    'Base Offset',
    'Top Offset',
    'Length',
    'Area',
    'Volume',
    'Top Extension Distance',
    'Base Extension Distance'
  )
GROUP BY
  e.index
ORDER BY
  e.index;
