SELECT pub.title AS 'Publication', ROUND(AVG(price),2) AS 'Average price'
FROM SC2207Lab5.PriceHistory p
JOIN SC2207Lab5.StorePublication sp ON p.storePublicationID = sp.storePublicationID
JOIN (
	SELECT p.title, p.publicationID
    FROM SC2207Lab5.Book p
    UNION
    SELECT p.title, p.publicationID
    FROM SC2207Lab5.Magazine p
) AS pub
ON sp.publicationID = pub.publicationID
WHERE pub.title = 'Harry Porter Finale'
AND p.startDate >= '2022-08-01'
AND p.endDate <= '2022-08-31'
GROUP BY pub.title;
