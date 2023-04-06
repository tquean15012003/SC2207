SELECT DISTINCT c.name AS 'Customer Name'
FROM SC2207Lab5.OrderMade o
JOIN SC2207Lab5.ItemPurchased ip ON o.orderID = ip.orderID
JOIN SC2207Lab5.StorePublication sp ON ip.storePublicationID = sp.storePublicationID
JOIN (
    SELECT p.title, p.publicationID, p.publisher
    FROM SC2207Lab5.Book p
    UNION
    SELECT p.title, p.publicationID, p.publisher
    FROM SC2207Lab5.Magazine p
) AS pub
ON pub.publicationID = sp.publicationID
JOIN SC2207Lab5.Customer c ON o.customerID = c.customerID
GROUP BY c.customerID, c.name, pub.publisher
HAVING COUNT(*) >= 5;