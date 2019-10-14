-- 1. non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

SELECT firstName, lastName, customerId, country
FROM Customer
WHERE Country != "USA";

-- 2. brazil_customers.sql: Provide a query only showing the Customers from Brazil.

SELECT firstName, lastName, customerId, country
FROM Customer
WHERE Country = "Brazil";

-- 3. brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT c.firstName, c.lastName, i.invoiceId, i.invoiceDate, i.billingCountry
FROM Invoice i
JOIN Customer c
ON i.customerId = c.CustomerId
WHERE c.Country = "Brazil";

-- 4. les_agents.sql: Provide a query showing only the Employees who are Sales Agents.

SELECT firstName, lastName, title
from Employee
WHERE title = "Sales Support Agent";

-- 5. unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT DISTINCT billingCountry
from Invoice;

-- 6. sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT e.firstName, e.lastName, i.Invoiceid, i.invoiceDate 
From Invoice i
join Customer c on i.customerId = c.CustomerId
join Employee e on c.SupportRepId = e.EmployeeId
WHERE e.Title = "Sales Support Agent"
order by e.employeeId

-- 7. invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT
e.FirstName || ' ' || e.LastName EmployeeName,
c.FirstName || ' ' || c.LastName CustomerName,
c.Country CustomerCountry,
i.Total
FROM Invoice i 
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId
ORDER BY CustomerName;

-- 8. total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?	
SELECT
SUBSTR(i.InvoiceDate, 1, 4) Year,
COUNT(*) NumberOfInvoices
from Invoice i
where Year = '2009' or Year = '2011'
GROUP BY Year;

-- 9. total_sales_{year}.sql: What are the respective total sales for each of those years?
SELECT
SUBSTR(i.InvoiceDate, 1, 4) Year,
COUNT(*) NumberOfInvoices,
SUM(i.Total) TotalSales
from Invoice i
where Year = '2009' or Year = '2011'
GROUP BY Year;

-- 10. invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT
il.InvoiceId,
COUNT(il.InvoiceId) LineItems
from InvoiceLine il
where il.InvoiceId = 37
GROUP BY il.InvoiceId;

-- 11. line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT
il.InvoiceId,
COUNT(il.InvoiceId) LineItems
from InvoiceLine il
GROUP BY il.InvoiceId;

-- 12. line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.
Select
il.*,
t.Name TrackName
from InvoiceLine il 
JOIN Track t on t.TrackId = il.TrackId;

-- 13. line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT
il.*,
t.Name TrackName,
a.Name ArtistName
from InvoiceLine il 
JOIN Track t on t.TrackId = il.TrackId
JOIN Album on Album.AlbumId = t.AlbumId
JOIN Artist a on a.ArtistId = Album.ArtistId;

-- 14. country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT
i.BillingCountry Country,
COUNT(i.BillingCountry) Invoices
from Invoice i
GROUP BY i.BillingCountry;

-- 15. playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.
SELECT
pl.Name Playlist,
COUNT(pl.Name) NumberOfTracks
from PlaylistTrack pt 
Join Playlist pl on pl.PlaylistId = pt.PlaylistId
GROUP BY pl.Name;

-- 16. tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
SELECT
t.Name TrackName,
a.Title AlbumTitle,
mt.Name MediaType,
g.Name Genre,
t.Composer,
t.Milliseconds,
t.Bytes,
t.UnitPrice
from Track t 
JOIN Album a on a.AlbumId = t.AlbumId
JOIN MediaType mt on mt.MediaTypeId = t.MediaTypeId
JOIN Genre g on g.GenreId = t.GenreId
GROUP By AlbumTitle;

-- 17. invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT
i.*,
COUNT(il.InvoiceId) LineItems
from InvoiceLine il
JOIN Invoice i on i.InvoiceId = il.InvoiceId
GROUP BY il.InvoiceId;

-- 18. sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.
SELECT
e.FirstName || ' ' || e.LastName as EmployeeName,
COUNT(*) TotalSales,
sum(i.Total) InvoiceTotal
FROM Invoice i 
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId
GROUP BY EmployeeName;

-- 19. top_2009_agent.sql: Which sales agent made the most in sales in 2009?
--Hint: Use the MAX function on a subquery.

Select 
EmployeeName,
InvoiceTotal,
MAX(TotalSales) TotalSales
FROM (
SELECT
e.FirstName || ' ' || e.LastName as EmployeeName,
COUNT(*) InvoiceTotal,
sum(i.Total) TotalSales
FROM Invoice i 
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId
where SUBSTR(i.InvoiceDate, 1, 4) = '2009'
GROUP BY EmployeeName);

-- 20. top_agent.sql: Which sales agent made the most in sales over all?
Select 
EmployeeName,
TotalSales,
MAX(InvoiceTotal) TotalSales
FROM (
SELECT
e.FirstName || ' ' || e.LastName as EmployeeName,
COUNT(*) TotalSales,
sum(i.Total) InvoiceTotal
FROM Invoice i 
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId
GROUP BY EmployeeName);

-- 21. sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.
SELECT
e.FirstName || ' ' || e.LastName as EmployeeName,
Count(*) NumberOfCustomers
FROM Customer c 
JOIN Employee e on e.EmployeeId = c.SupportRepId
GROUP BY EmployeeName;

-- 22. sales_per_country.sql: Provide a query that shows the total sales per country.
SELECT
i.BillingCountry Country,
COUNT(*) TotalSales,
sum(i.Total) InvoiceTotal
FROM Invoice i 
GROUP BY Country;

-- 23. Which country's customers spent the most?
SELECT 
Country,
MAX(InvoiceTotal) InvoiceTotal
FROM (
SELECT
i.BillingCountry Country,
COUNT(*) TotalSales,
sum(i.Total) InvoiceTotal
FROM Invoice i 
GROUP BY Country
);

-- 24. Provide a query that shows the most purchased track of 2013.
SELECT
Track,
MAX(TotalPurchased) TotalPurchased
From (
SELECT 
t.Name Track,
COUNT(*) TotalPurchased
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
JOIN Invoice i where i.InvoiceId IN (
SELECT
i.InvoiceId
from Invoice i
where SUBSTR(i.InvoiceDate, 1, 4) = '2013'
) 
GROUP BY Track);

-- 25. Provide a query that shows the top 5 most purchased tracks over all.
SELECT
Track,
TotalPurchased
FROM (SELECT DISTINCT
t.Name Track,
COUNT(il.TrackId) TotalPurchased
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
GROUP BY il.TrackId)
ORDER BY TotalPurchased
DESC LIMIT 5;

-- 26. Provide a query that shows the top 3 best selling artists.
SELECT *
FROM (SELECT DISTINCT
a.Name Artist,
COUNT(a.ArtistId) TracksSold
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
JOIN Album al on al.AlbumId = t.AlbumId
JOIN Artist a on a.ArtistId = al.ArtistId
GROUP BY a.ArtistId)
ORDER BY TracksSold
DESC LIMIT 3;

-- 27. Provide a query that shows the most purchased Media Type.
SELECT 
MediaType,
MAX(TypeSold) TypeSold
FROM (SELECT DISTINCT
mt.Name MediaType,
COUNT(mt.MediaTypeId) TypeSold
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
JOIN MediaType mt on mt.MediaTypeId = t.MediaTypeId
GROUP BY mt.MediaTypeId);







