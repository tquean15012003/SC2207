SELECT pub.publicationID AS 'Publication ID', pub.title AS 'Title', AVG(TIMESTAMPDIFF(DAY, o.timeCreated, ips_delivered.timeCreated)) AS 'Average days to delivery'
FROM SC2207Lab5.OrderMade o
RIGHT JOIN SC2207Lab5.ItemPurchased ip ON o.orderID = ip.orderID
INNER JOIN SC2207Lab5.ItemPurchasedStatus ips_delivered ON ip.itemPurchasedID = ips_delivered.itemPurchasedID AND ips_delivered.statusDescription = 'delivered'
INNER JOIN SC2207Lab5.StorePublication sp ON ip.storePublicationID = sp.storePublicationID
JOIN (
    SELECT p.title, p.publicationID
    FROM SC2207Lab5.Book p
    UNION
    SELECT p.title, p.publicationID
    FROM SC2207Lab5.Magazine p
) AS pub
ON pub.publicationID = sp.publicationID
WHERE MONTH(o.timeCreated) = 6 AND YEAR(o.timeCreated) = 2022
GROUP BY pub.publicationID, pub.title;