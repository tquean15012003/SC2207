SELECT pub.title AS Publication, COUNT(DISTINCT sp.storeID) AS 'Number of bookstores'
FROM (
	SELECT p.title, p.publicationID, p.publisher
    FROM SC2207Lab5.Book p
    UNION
    SELECT p.title, p.publicationID, p.publisher
    FROM SC2207Lab5.Magazine p
) AS pub
JOIN SC2207Lab5.StorePublication sp ON pub.publicationID = sp.publicationID
WHERE pub.publisher = 'Nanyang Publisher Company'
GROUP BY pub.title

