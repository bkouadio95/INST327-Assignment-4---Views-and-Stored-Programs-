/*Answer 1*/

USE ap;
CREATE OR REPLACE VIEW late_invoices AS
SELECT vendor_name AS "The vendor’s name", invoice_number AS "The invoice number",
       CONCAT(DATE_FORMAT(invoice_due_date, "%M %d"), "th") AS "The invoice’s due date",
       CONCAT(DATE_FORMAT(payment_date, "%M %d"), "th") AS "The date the invoice was paid",
       DATEDIFF(payment_date, invoice_due_date) AS "Number of days late",
       CONCAT("$ ", FORMAT(invoice_total,0)) AS "Invoice’s total",
       (invoice_total - credit_total - payment_total) AS "Balance due"
FROM vendors AS v 
JOIN  invoices AS i ON v.vendor_id = i.vendor_id
WHERE payment_date > invoice_due_date OR invoice_total - credit_total - payment_total> 0 
ORDER BY "Number of days late" AND  invoice_total DESC;