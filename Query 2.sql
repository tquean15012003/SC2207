SELECT pub.title as 'Publication', ROUND(AVG(r.rating),2) AS 'Average rating'
FROM (
	SELECT p.title, p.publicationID
	FROM (
		SELECT p.title, p.publicationID
		FROM SC2207Lab5.Book p
		UNION
		SELECT p.title, p.publicationID
		FROM SC2207Lab5.Magazine p
    ) as p
	JOIN SC2207Lab5.StorePublication sp ON p.publicationID = sp.publicationID
	JOIN SC2207Lab5.ItemPurchased ip ON sp.storePublicationID = ip.storePublicationID
	JOIN SC2207Lab5.Review r ON ip.itemPurchasedID = r.itemPurchasedID
	WHERE MONTH(r.timeCreated) = 8 AND YEAR(r.timeCreated) = 2022 AND r.rating = 5
	GROUP BY p.title, p.publicationID
	HAVING COUNT(*) >= 10) as pub
JOIN SC2207Lab5.StorePublication sp ON pub.publicationID = sp.publicationID
JOIN SC2207Lab5.ItemPurchased ip ON sp.storePublicationID = ip.storePublicationID
JOIN SC2207Lab5.Review r ON ip.itemPurchasedID = r.itemPurchasedID
GROUP BY pub.title
ORDER BY AVG(r.rating) DESC;
