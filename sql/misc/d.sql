CREATE OR REPLACE VIEW denorm_descriptors
AS SELECT dsc.index as index, strName.String as Name, strUnit.String as Units, strGroup.String as Group, strType.String as Type
FROM Descriptors as dsc
LEFT OUTER JOIN Strings as strName 
On   strName.index = dsc.Name
LEFT OUTER JOIN Strings as strUnit 
On   strUnit.index = dsc.Units
LEFT OUTER JOIN Strings as strGroup 
On   strGroup.index = dsc.Group
LEFT OUTER JOIN Strings as strType 
On   strType.index = dsc.Type;


SELECT * FROM denorm_descriptors;
