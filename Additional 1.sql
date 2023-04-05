SELECT p.title as 'Publication', COUNT(pc.complaintID) AS 'Number of complaints' 
FROM (
    SELECT publicationID, title
    FROM Book
    UNION
    SELECT publicationID, title
    FROM Magazine
) AS p
LEFT JOIN PublicationComplaint pc ON p.publicationID = pc.publicationID
GROUP BY p.title
ORDER BY COUNT(pc.complaintID) DESC
LIMIT 1;	