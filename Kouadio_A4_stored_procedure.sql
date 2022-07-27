/*Answer 2 */

USE ap;

DROP PROCEDURE IF EXISTS owed_to_state_vendors;

DELIMITER //
CREATE PROCEDURE owed_to_state_vendors (
	vendor_state_param VARCHAR(50)
	)	 
BEGIN 
  DECLARE vendor_state_param VARCHAR(50);
  
  WITH this_cte AS (
	SELECT vendor_state, vendor_name,
                SUM(invoice_total) - SUM(payment_total) AS "Owed",
	FROM vendors v
	JOIN invoices i
            ON v.vendor_id = i.vendor_id
        GROUP BY invoice_total
        HAVING "Owed" > 0
        ORDER BY "Owed" DESC)

  SELECT vendor_state, vendor_name, MAX("Owed")
  FROM this_cte
  WHERE vendor_state = vendor_state_param;
	)
    END //
    
    DELIMITER ;
    CALL owed_to_state_vendors('CA');
    
