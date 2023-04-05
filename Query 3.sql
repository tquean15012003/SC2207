SELECT AVG(DATEDIFF(delivery_date, ordering_date)) as avg_delivery_time
FROM (
    SELECT DISTINCT o.orderID, o.timeCreated AS ordering_date, o.timeDelivery AS delivery_date
    FROM SC2207Lab5.OrderMade o
    JOIN SC2207Lab5.ItemPurchased ip ON o.orderID = ip.orderID
    JOIN SC2207Lab5.StorePublication sp ON ip.storePublicationID = sp.storePublicationID
    JOIN (
        SELECT p.title, p.publicationID
        FROM SC2207Lab5.Book p
        UNION
        SELECT p.title, p.publicationID
        FROM SC2207Lab5.Magazine p
    ) AS pub
    ON sp.publicationID = pub.publicationID
    WHERE MONTH(o.timeCreated) = 6 AND YEAR(o.timeCreated) = 2022
    AND o.timeDelivery IS NOT NULL
) q;