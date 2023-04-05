SELECT o.customerID, most_num_complaints.num_complaints, sp.publicationID, ip.price
FROM SC2207Lab5.OrderMade o
JOIN SC2207Lab5.ItemPurchased ip ON o.orderID = ip.orderID
JOIN SC2207Lab5.StorePublication sp ON ip.storePublicationID = sp.storePublicationID
JOIN (
    SELECT c.customerID, COUNT(*) AS num_complaints
    FROM Customer c
    LEFT JOIN (
        SELECT bc.customerID, bc.complaintID FROM SC2207Lab5.BookstoreComplaint bc
        UNION
        SELECT pc.customerID, pc.complaintID FROM SC2207Lab5.PublicationComplaint pc
    ) AS complaints
    ON c.customerID = complaints.customerID
    GROUP BY c.customerID
    ORDER BY num_complaints DESC
    LIMIT 1
) AS most_num_complaints
ON o.customerID = most_num_complaints.customerID
ORDER BY ip.price DESC
LIMIT 1;