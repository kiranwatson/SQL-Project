/* Question-1
The highest number of invoices belongs to which country?   */
SELECT 
    BillingCountry,
    COUNT(InvoiceId) AS TotalInvoices
FROM 
    invoices
GROUP BY 
    BillingCountry
ORDER BY 
    TotalInvoices DESC
LIMIT 1;


/* Question-2 
Which city corresponds to the best customers?  */
SELECT 
    c.City,
    SUM(i.Total) AS TotalSpent
FROM 
    customers c
INNER JOIN 
    invoices i ON c.CustomerId = i.CustomerId
GROUP BY 
    c.City
ORDER BY 
    TotalSpent DESC;


/* Question-3
Name the best customer (customer who spent the most money).  */
SELECT 
    c.FirstName,
    c.LastName,
    SUM(i.Total) AS TotalSpent
FROM 
    customers c
INNER JOIN 
    invoices i ON c.CustomerId = i.CustomerId
GROUP BY 
    c.CustomerId
ORDER BY 
    TotalSpent DESC
LIMIT 1;


/* Question-4
Suppose you want to host a rock concert in a city and want to know which location should 
host it. Query the dataset to find the city with the most rock-music listeners to answer this 
question */
SELECT 
    c.City,
    COUNT(pt.PlaylistId) AS RockListeners
FROM 
    customers c
INNER JOIN 
    invoices i ON c.CustomerId = i.CustomerId
INNER JOIN 
    invoice_items ii ON i.InvoiceId = ii.InvoiceId
INNER JOIN 
    tracks t ON ii.TrackId = t.TrackId
INNER JOIN 
    genres g ON t.GenreId = g.GenreId
INNER JOIN 
    playlist_track pt ON t.TrackId = pt.TrackId
INNER JOIN 
    playlists pl ON pt.PlaylistId = pl.PlaylistId
WHERE 
    g.Name = 'Rock'
GROUP BY 
    c.City
ORDER BY 
    RockListeners DESC
LIMIT 1;


/* Question-5 
If you want to know which artists the store should invite, find out who is the highest-paid 
and most-listened-to  */
SELECT 
    ar.Name AS ArtistName,
    COUNT(t.TrackId) AS TotalTracks,
    SUM(ii.UnitPrice) AS TotalRevenue
FROM 
    artists ar
INNER JOIN 
    albums al ON ar.ArtistId = al.ArtistId
INNER JOIN 
    tracks t ON al.AlbumId = t.AlbumId
INNER JOIN 
    invoice_items ii ON t.TrackId = ii.TrackId
GROUP BY 
    ar.ArtistId
ORDER BY 
    TotalRevenue DESC, TotalTracks DESC
LIMIT 1;


/* Question-6 
Find the total sales amount for each genre, ordered by the genre with the highest total sales 
first */
SELECT 
    g.Name AS Genre,
    SUM(ii.UnitPrice * ii.Quantity) AS TotalSales
FROM 
    genres g
INNER JOIN 
    tracks t ON g.GenreId = t.GenreId
INNER JOIN 
    invoice_items ii ON t.TrackId = ii.TrackId
GROUP BY 
    g.GenreId
ORDER BY 
    TotalSales DESC;


/* Question-7
Identify the top 5 customers who have made the most purchases in terms of the number of 
invoices  */
SELECT 
    c.FirstName || ' ' || c.LastName AS CustomerName,
    COUNT(i.InvoiceId) AS TotalInvoices
FROM 
    customers c
INNER JOIN 
    invoices i ON c.CustomerId = i.CustomerId
GROUP BY 
    c.CustomerId
ORDER BY 
    TotalInvoices DESC
LIMIT 5;


/* Question-8
List the employees who have sold the most in terms of total sales amount. */
SELECT 
    e.FirstName || ' ' || e.LastName AS EmployeeName,
    SUM(i.Total) AS TotalSales
FROM 
    employees e
INNER JOIN 
    customers c ON e.EmployeeId = c.SupportRepId
INNER JOIN 
    invoices i ON c.CustomerId = i.CustomerId
GROUP BY 
    e.EmployeeId
ORDER BY 
    TotalSales DESC;


/* Question- 9
Determine the average revenue per customer for each country, only considering countries 
with more than 5 customers */
SELECT 
    c.Country,
    COUNT(c.CustomerId) AS TotalCustomers,
    AVG(i.Total) AS AverageRevenuePerCustomer
FROM 
    customers c
INNER JOIN 
    invoices i ON c.CustomerId = i.CustomerId
GROUP BY 
    c.Country
HAVING 
    TotalCustomers > 5
ORDER BY 
    AverageRevenuePerCustomer DESC;


/* Question-10
Find the top 3 best-selling albums in terms of total sales amount.*/
SELECT 
    al.Title AS AlbumTitle,
    ar.Name AS ArtistName,
    SUM(ii.UnitPrice * ii.Quantity) AS TotalSales
FROM 
    albums al
INNER JOIN 
    artists ar ON al.ArtistId = ar.ArtistId
INNER JOIN 
    tracks t ON al.AlbumId = t.AlbumId
INNER JOIN 
    invoice_items ii ON t.TrackId = ii.TrackId
GROUP BY 
    al.AlbumId
ORDER BY 
    TotalSales DESC
LIMIT 3;

