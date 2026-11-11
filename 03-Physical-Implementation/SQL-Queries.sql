
1.1     Lista för- och efternamn på alla anställda vars lön överstiger 30000, i alfabetisk ordning

SELECT Name, Salary
FROM Employee
WHERE Salary > 30000
ORDER BY Name;

1.2     Lista totala kostnaden för serviceavgifter för bokningar med minst ett barn, inklusive 
gästens och service namn

SELECT G.Name AS GuestName, S.ServiceName, SUM(RS.Price) AS TotalServiceCost
FROM Room_Service RS
JOIN Service S ON RS.ServiceID = S.ServiceID
JOIN Room_Booking RB ON RS.RoomID = RB.RoomID
JOIN Booking B ON RB.BookingID = B.BookingID
JOIN Guest_Booking GB ON B.BookingID = GB.BookingID
JOIN Guest G ON GB.GuestID = G.GuestID
WHERE GB.NumberOfChildren > 0
GROUP BY G.Name, S.ServiceName;

1.3     Lista namn och e-post för gäster som har använt rabattkod

SELECT DISTINCT G.Name, G.Email
FROM Guest G
JOIN Guest_Booking GB ON G.GuestID = GB.GuestID
JOIN Booking B ON GB.BookingID = B.BookingID
WHERE B.Discount IS NOT NULL;

1.4     Lista medelvärdet på rumskostnaden per rumstyp och per betalningsmetod

SELECT 
    RoomType.TypeName AS RoomType,
    PayMethod.MethodName AS PaymentMethod,
    AVG(Hotel_Room_Price.StandardPricePerNight) AS AverageRoomCost
FROM 
    RoomType
JOIN 
    Hotel_Room_Price ON Hotel_Room_Price.RoomTypeID = RoomType.RoomTypeID
JOIN 
    PayMethod ON PayMethod.PayMethodID = Hotel_Room_Price.HotelID
GROUP BY 
    RoomType.TypeName, PayMethod.MethodName
ORDER BY 
    RoomType.TypeName, PayMethod.MethodName;

1.5     Lista namnet och antal bokade rum för varje hotel

SELECT 
    Hotel.HotelName,
    COUNT(Room_Booking.RoomID) AS NumberOfBookedRooms
FROM 
    Hotel
LEFT JOIN 
    Room ON Room.HotelID = Hotel.HotelID
LEFT JOIN 
    Room_Booking ON Room_Booking.RoomID = Room.RoomID
GROUP BY 
    Hotel.HotelName
ORDER BY 
    Hotel.HotelName;

1.6     Lista antalet rum, incheckningsdatum, utcheckningsdatum och antal barn per hotell och gäst för bokningar i maj 2025

SELECT 
    Hotel.HotelName,
    Guest.GuestID,
    COUNT(Room_Booking.RoomID) AS NumberOfRooms,
    Booking.CheckInDate,
    Booking.CheckOutDate,
    SUM(Guest_Booking.NumberOfChildren) AS NumberOfChildren
FROM 
    Hotel
JOIN 
    Room ON Room.HotelID = Hotel.HotelID
JOIN 
    Room_Booking ON Room_Booking.RoomID = Room.RoomID
JOIN 
    Booking ON Booking.BookingID = Room_Booking.BookingID
JOIN 
    Guest_Booking ON Guest_Booking.BookingID = Booking.BookingID
JOIN 
    Guest ON Guest.GuestID = Guest_Booking.GuestID
WHERE 
    Booking.CheckInDate BETWEEN '2025-05-01' AND '2025-05-31'
GROUP BY 
    Hotel.HotelName, Guest.GuestID, Booking.CheckInDate, Booking.CheckOutDate
ORDER BY 
    Hotel.HotelName, Guest.GuestID, Booking.CheckInDate;
 
1.7     Lista hotell och antal bokningsbara rum

SELECT 
    Hotel.HotelName,
    COUNT(Room.RoomID) AS NumberOfAvailableRooms
FROM 
    Hotel
JOIN 
    Room ON Room.HotelID = Hotel.HotelID
LEFT JOIN 
    Room_Booking ON Room_Booking.RoomID = Room.RoomID
WHERE 
    Room_Booking.BookingID IS NULL  -- Filtrerar bort rummen som är bokade
GROUP BY 
    Hotel.HotelName
ORDER BY 
    Hotel.HotelName;

1.8     Lista summan av de tre högsta serviceavgifterna per bokning

SELECT 
    Booking.BookingID,
    Service.ServiceName,
    SUM(Room_Service.Price) AS TopTreService
FROM 
    Booking
JOIN 
    Room_Booking ON Room_Booking.BookingID = Booking.BookingID
JOIN 
    Room_Service ON Room_Service.RoomID = Room_Booking.RoomID
JOIN 
    Service ON Service.ServiceID = Room_Service.ServiceID
GROUP BY 
    Booking.BookingID, Service.ServiceName
ORDER BY 
    TopTreService DESC
LIMIT 3;

1.9     Lista gäster som har bokat på det högst rankade hotellet

SELECT 
    Guest.Name, 
    Guest.Email, 
    Guest.PhoneNumber, 
    Booking.CheckInDate, 
    Booking.CheckOutDate
FROM 
    Guest
JOIN 
    Guest_Booking ON Guest_Booking.GuestID = Guest.GuestID
JOIN 
    Booking ON Booking.BookingID = Guest_Booking.BookingID
JOIN 
    Room_Booking ON Room_Booking.BookingID = Booking.BookingID
JOIN 
    Room ON Room.RoomID = Room_Booking.RoomID
JOIN 
    Hotel ON Hotel.HotelID = Room.HotelID
WHERE 
    Hotel.Rating = (SELECT MAX(Rating) FROM Hotel)  -- Filtrera på hotell med högsta betyg
ORDER BY 
    Hotel.HotelName;

1.10 Lista hotell där medelvärdet för rumskostnad överstiger 1000

SELECT 
    Hotel.HotelName, 
    AVG(Hotel_Room_Price.StandardPricePerNight) AS AverageRoomCost
FROM 
    Hotel 
JOIN 
    Hotel_Room_Price ON Hotel_Room_Price.HotelID = Hotel.HotelID
GROUP BY 
    Hotel.HotelName 
HAVING 
    AVG(Hotel_Room_Price.StandardPricePerNight) > 1000
ORDER BY 
    AverageRoomCost DESC;
 
