SELECT pub.title as Publication, feb_qty as 'February Quantity', mar_qty AS 'March Quantity', apr_qty AS 'April Quantity'
FROM (
    SELECT p.title, p.publicationID
    FROM Book p
    UNION
    SELECT p.title, p.publicationID
    FROM Magazine p
) AS pub
JOIN (
    SELECT sp.publicationID, SUM(ip.quantity) AS apr_qty
    FROM StorePublication sp
    JOIN ItemPurchased ip ON sp.storePublicationID = ip.storePublicationID
    JOIN OrderMade o ON ip.orderID = o.orderID
    WHERE MONTH(o.timeCreated) = Month(CURDATE()) AND YEAR(o.timeCreated) = YEAR(CURDATE())
    GROUP BY sp.publicationID
) AS jun ON pub.publicationID = jun.publicationID
JOIN (
    SELECT sp.publicationID, SUM(ip.quantity) AS mar_qty
    FROM StorePublication sp
    JOIN ItemPurchased ip ON sp.storePublicationID = ip.storePublicationID
    JOIN OrderMade o ON ip.orderID = o.orderID
    WHERE MONTH(o.timeCreated) = Month(CURDATE()) - 1 AND YEAR(o.timeCreated) = YEAR(CURDATE())
    GROUP BY sp.publicationID
) AS jul ON pub.publicationID = jul.publicationID
JOIN (
    SELECT sp.publicationID, SUM(ip.quantity) AS feb_qty
    FROM StorePublication sp
    JOIN ItemPurchased ip ON sp.storePublicationID = ip.storePublicationID
    JOIN OrderMade o ON ip.orderID = o.orderID
    WHERE MONTH(o.timeCreated) = Month(CURDATE()) - 2 AND YEAR(o.timeCreated) = YEAR(CURDATE())
    GROUP BY sp.publicationID
) AS aug ON pub.publicationID = aug.publicationID
WHERE apr_qty > mar_qty AND mar_qty > feb_qty;