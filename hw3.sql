Use Northwind
GO
-- 1.      List all cities that have both Employees and Customers.
select e.City 
from Employees e join Customers c on c.City = e.City;

-- 2.      List all cities that have Customers but no Employee.
    -- a.      Use sub-query
select City 
from Customers
where City not in (
    select distinct City
    from Employees
)

    -- b.      Do not use sub-query
select c.City
from Customers c left join Employees e on c.city = e.City
where e.EmployeeID is null

-- 3.      List all products and their total order quantities throughout all orders.
select p.ProductName, Sum(od.Quantity) as TotalOrderQuantities
from Products p join [Order Details] od on p.ProductID = od.ProductID 
group by p.ProductName
-- order by Sum(od.Quantity) DESC

-- 4.      List all Customer Cities and total products ordered by that city.
select c.City, Sum(od.Quantity) as TotalProduct
from Customers c join Orders o on c.CustomerID = o.CustomerID join [Order Details] od on o.OrderID = od.OrderID 
group by c.City
-- order by Sum(od.Quantity) DESC

-- 5.      List all Customer Cities that have at least two customers.
select c.City
from Customers c
group by c.City
having count(c.CustomerID) >= 2


-- 6.      List all Customer Cities that have ordered at least two different kinds of products.
select c.City 
from Customers c join Orders o on c.CustomerID = o.CustomerID join [Order Details] od on o.OrderID = od.OrderID
group by c.City
having Count(distinct od.ProductID) >= 2

-- 7.      List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
select distinct c.CustomerID, c.ContactName
from Customers c join Orders o on o.CustomerID = c.CustomerID
where o.ShipCity <> c.City

-- 8.      List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
With ProductPopularityCTE
AS(
    select p.ProductID, p.ProductName, c.City, Avg(od.UnitPrice) as AvgPrice, RANK() OVER(ORDER BY Sum(od.Quantity) DESC) PopRNK
    from Products p join [Order Details] od on od.ProductID = p.ProductID join Orders o on o.OrderID = od.OrderID join Customers c on c.CustomerID = o.CustomerID
    group by p.ProductID, p.ProductName, c.City
)
select pp.ProductName, pp.AvgPrice, pp.City
from ProductPopularityCTE pp
where pp.PopRNK <= 5

-- Alternatively
-- With ProductPopularityCTE
-- AS(
--     select p.ProductID, p.ProductName, c.City, Avg(od.UnitPrice) as AvgPrice, Sum(od.Quantity) as Popularity
--     from Products p join [Order Details] od on od.ProductID = p.ProductID join Orders o on o.OrderID = od.OrderID join Customers c on c.CustomerID = o.CustomerID
--     group by p.ProductID, p.ProductName, c.City
-- )
-- select TOP 5 pp.ProductName, pp.AvgPrice, pp.City
-- from ProductPopularityCTE pp
-- order by pp.Popularity desc

-- 9.      List all cities that have never ordered something but we have employees there.
    -- a.      Use sub-query
select distinct e.City
from Employees e
where e.City not in (
    select distinct o.ShipCity
    from Orders o 
)

    -- b.      Do not use sub-query
select distinct e.City
from Employees e left join Orders o on e.City = o.ShipCity
where o.OrderID is null 
    
-- 10.  List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)
-- WITH EmployeeSales AS (
--     SELECT e.City, COUNT(o.OrderID) AS TotalOrders
--     FROM Orders o
--     INNER JOIN Employees e
--     ON o.EmployeeID = e.EmployeeID
--     GROUP BY e.City
-- ),
-- CustomerOrders AS (
--     SELECT c.City, SUM(od.Quantity) AS TotalProducts
--     FROM Orders o
--     INNER JOIN Customers c
--     ON o.CustomerID = c.CustomerID
--     INNER JOIN [Order Details] od
--     ON o.OrderID = od.OrderID
--     GROUP BY c.City
-- )
-- SELECT es.City
-- FROM EmployeeSales es
-- INNER JOIN CustomerOrders co
-- ON es.City = co.City
-- ORDER BY co.TotalProducts DESC, es.TotalOrders DESC


select MostOrder.City
from (
    select e.City, RANK() OVER(ORDER BY Count(o.OrderID) DESC) RNK 
    from Employees e join Orders o on e.EmployeeID = o.EmployeeID
    group by e.City) MostOrder
join 
(
    select o.ShipCity, RANK() OVER(ORDER BY Sum(od.quantity) DESC) RNK 
    from Orders o join [Order Details] od on o.OrderID = od.OrderID
    group by o.ShipCity
) MostProductQuantity on MostOrder.City = MostProductQuantity.ShipCity
where MostOrder.RNK = 1 and MostProductQuantity.RNK = 1


-- 11. How do you remove the duplicates record of a table?
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Column1, Column2 ORDER BY ID) AS RowNum
    FROM Table
)
DELETE FROM CTE
WHERE RowNum > 1;

-- OR 
select distinct *
into TABLE
FROM Table