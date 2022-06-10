-- All tracks with their album name and artist name
SELECT Tr.Name, A.Title AS "Album title", Art.Name As "Artist name"
FROM (tracks Tr LEFT JOIN albums A  ON Tr.AlbumId = A.AlbumId ) LEFT JOIN artists Art ON A.ArtistId = Art.ArtistId;

-- All tracks by AC/DC with their album name
SELECT Tr.Name, A.Title AS "Album title"
FROM (tracks Tr LEFT JOIN albums A  ON Tr.AlbumId = A.AlbumId ) LEFT JOIN artists Art ON A.ArtistId = Art.ArtistId
WHERE Art.Name = 'AC/DC';

--All Customers that brought a playlist AC/DC tracks with the Employees that sold them the playlist
SELECT C.LastName || " " || C.FirstName AS 'Customer Name', E.LastName || " " || E.FirstName AS 'Emloyee name', T.Name, Art.Name
FROM ( ( ( ( ( (customers C JOIN employees E ON C.SupportRepId = E.EmployeeId)
    LEFT JOIN invoices I ON I.CustomerId = C.CustomerId ) LEFT JOIN invoice_items II ON Ii.InvoiceId = I.InvoiceId )
    LEFT JOIN tracks T On II.TrackId = T.TrackId ) LEFT JOIN albums A ON T.AlbumId = A.AlbumId )
    LEFT JOIN artists Art ON A.ArtistId = A.ArtistId )
WHERE Art.Name = 'AC/DC';

--with the most expensive track of AC/DC in the playlist
--hero all same price
SELECT C.LastName || ' ' || C.FirstName AS 'Customer Name', E.LastName || ' ' || E.FirstName AS 'Emloyee name', T.Name, Art.Name
FROM ( ( ( ( ( (customers C JOIN employees E ON C.SupportRepId = E.EmployeeId)
    LEFT JOIN invoices I ON I.CustomerId = C.CustomerId ) LEFT JOIN invoice_items II ON Ii.InvoiceId = I.InvoiceId )
    LEFT JOIN tracks T On II.TrackId = T.TrackId ) LEFT JOIN albums A ON T.AlbumId = A.AlbumId )
    LEFT JOIN artists Art ON A.ArtistId = A.ArtistId )
WHERE Art.Name = 'AC/DC'
  AND T.UnitPrice = (
    SELECT MAX(T2.UnitPrice)
    FROM tracks T2
);
