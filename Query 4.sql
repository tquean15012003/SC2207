SELECT e.name, e.employeeID, LatencyTime.avg_handling_time
FROM SC2207Lab5.Employee e
INNER JOIN (
    SELECT complaints.employeeID, AVG(TIMESTAMPDIFF(SECOND, cs_beinghandled.timestamp, cs_addressed.timestamp)) AS avg_handling_time
    FROM (
        SELECT bc.employeeID, bc.complaintID FROM SC2207Lab5.BookstoreComplaint bc
        UNION
        SELECT pc.employeeID, pc.complaintID FROM SC2207Lab5.PublicationComplaint pc
    ) AS complaints
    INNER JOIN SC2207Lab5.ComplaintStatus cs_beinghandled ON complaints.complaintID = cs_beinghandled.complaintID AND cs_beinghandled.status = 'being handled'
    INNER JOIN SC2207Lab5.ComplaintStatus cs_addressed ON complaints.complaintID = cs_addressed.complaintID AND cs_addressed.status = 'addressed'
    GROUP BY complaints.employeeID
    ORDER BY avg_handling_time ASC
    LIMIT 1
) LatencyTime
ON e.employeeID = LatencyTime.employeeID;