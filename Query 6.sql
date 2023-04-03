SELECT s.storeName AS 'Bookstore', SUM(ip.price * ip.quantity) AS Revenue
FROM SC2207Lab5.Bookstore s
JOIN SC2207Lab5.StorePublication sp ON s.storeID = sp.storeID
JOIN SC2207Lab5.ItemPurchased ip ON sp.storePublicationID = ip.storePublicationID
JOIN SC2207Lab5.OrderMade o ON ip.orderID = o.orderID
WHERE MONTH(o.timeCreated) = 8 AND YEAR(o.timeCreated) = 2022
GROUP BY s.storeID
ORDER BY SUM(ip.price * ip.quantity) DESC
LIMIT 1;
