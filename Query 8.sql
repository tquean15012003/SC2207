SELECT p.title as Publication, top_pubs.total_quantity as 'Quantity'
FROM (
  SELECT sp.publicationID, SUM(ip.quantity) AS total_quantity
  FROM SC2207Lab5.StorePublication sp
  JOIN SC2207Lab5.ItemPurchased ip ON sp.storePublicationID = ip.storePublicationID
  JOIN SC2207Lab5.OrderMade o ON ip.orderID = o.orderID
  WHERE MONTH(o.timeCreated) = 8 AND YEAR(o.timeCreated) = 2022
  GROUP BY sp.publicationID
  ORDER BY SUM(ip.quantity) DESC
  LIMIT 3
) AS top_pubs
JOIN (
  SELECT p.title, p.publicationID
  FROM SC2207Lab5.Book p
  UNION
  SELECT p.title, p.publicationID
  FROM SC2207Lab5.Magazine p
) AS p
ON top_pubs.publicationID = p.publicationID
WHERE p.publicationID NOT IN (
  SELECT sp.publicationID
  FROM SC2207Lab5.StorePublication sp
  JOIN SC2207Lab5.ItemPurchased ip ON sp.storePublicationID = ip.storePublicationID
  JOIN SC2207Lab5.OrderMade o ON ip.orderID = o.orderID
  WHERE MONTH(o.timeCreated) = 7 AND YEAR(o.timeCreated) = 2022
);