Use AdventureWorks2019
-- 1.      How many products can you find in the Production.Product table?
select count(*) as TotalProducts
from Production.Product;

-- 2.      Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
select count(*) as TotalProductsWithSubcategory
from Production.Product
where ProductSubcategoryID is not null;

-- 3.      How many Products reside in each SubCategory? Write a query to display the results with the following titles.
-- ProductSubcategoryID CountedProducts
-- -------------------- ---------------
select ProductSubcategoryID, count(*) as CountedProducts
from Production.Product
group by ProductSubcategoryID;

-- 4.      How many products that do not have a product subcategory.
select count(*) as TotalProductsWithNotSubcategory
from Production.Product
where ProductSubcategoryID is null;

-- 5.      Write a query to list the sum of products quantity in the Production.ProductInventory table.
select sum(Quantity) as TotalProductsQuantity 
from Production.ProductInventory;

-- 6.    Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
--               ProductID    TheSum
--               -----------        ----------
select ProductID, sum(Quantity) as TheSum
from Production.ProductInventory
where LocationId = 40 
group by ProductID
having sum(Quantity) < 100;

-- 7.    Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
--     Shelf      ProductID    TheSum
--     ----------   -----------        -----------
select Shelf, ProductID, sum(Quantity) as TheSum
from Production.ProductInventory
where LocationId = 40 
group by Shelf, ProductID
having sum(Quantity) < 100;

-- 8. Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.
select ProductID, avg(Quantity) as AvgQuantity
from Production.ProductInventory
where LocationId = 10
group by ProductID;

-- 9.    Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
--     ProductID   Shelf      TheAvg
--     ----------- ---------- -----------
select ProductID, Shelf, avg(Quantity) as TheAvg
from Production.ProductInventory
group by ProductID, Shelf;

-- 10.  Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
--     ProductID   Shelf      TheAvg
--     ----------- ---------- -----------
select ProductID, Shelf, avg(Quantity) as TheAvg
from Production.ProductInventory
where Shelf <> 'N/A'
group by ProductID, Shelf

-- 11.  List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
--     Color                        Class              TheCount          AvgPrice
--     -------------- - -----    -----------            ---------------------
select Color, Class, count(*) as TheCount, avg(ListPrice) as AvgPrice
from Production.Product
where Color is not null and Class is not null
group by Color, Class;

-- Joins:
-- 12.   Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.
--     Country                        Province
--     ---------                          ----------------------
select cr.name as Country, sp.name as Province
from person.CountryRegion cr join person.StateProvince sp on cr.CountryRegionCode = sp.CountryRegionCode;

-- 13.  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
--     Country                        Province
--     ---------                          ----------------------
select cr.name as Country, sp.name as Province
from person.CountryRegion cr join person.StateProvince sp on cr.CountryRegionCode = sp.CountryRegionCode
where cr.name = 'Germany' or cr.name = 'Canada';
GO

--  Using Northwnd Database: (Use aliases for all the Joins)
Use Northwind
-- 14.  List all Products that has been sold at least once in last 27 years.
select p.ProductName
from Orders o join [Order Details] od on o.OrderID = od.OrderID join Products p on od.ProductID = p.ProductID
where year(o.OrderDate) between 1997 and 2024;

-- 15.  List top 5 locations (Zip Code) where the products sold most.
select top 5 o.ShipPostalCode as "Zip Code"
from Orders o join [Order Details] od on o.OrderID = od.OrderID
group by o.ShipPostalCode
order by Count(od.Quantity) desc;

-- 16.  List top 5 locations (Zip Code) where the products sold most in last 27 years.
select top 5 o.ShipPostalCode as "Zip Code"
from Orders o join [Order Details] od on o.OrderID = od.OrderID
where year(o.OrderDate) between 1997 and 2024
group by o.ShipPostalCode
order by Count(od.Quantity) desc;

-- 17.   List all city names and number of customers in that city.     
select City, count(*) as NumOfCustomers
from Customers
group by City;

-- 18.  List city names which have more than 2 customers, and number of customers in that city
select City, count(CustomerID) as NumOfCustomers
from Customers
group by City
having count(CustomerID) > 2;

-- 19.  List the names of customers who placed orders after 1/1/98 with order date.
select c.ContactName,o.OrderDate
from Customers c join Orders o on c.CustomerID = o.CustomerID
where o.OrderDate > '1998-01-01';

-- 20.  List the names of all customers with most recent order dates
-- Individual Most Recent Order Dates Per Customer
select c.ContactName, Max(o.OrderDate) as MostRecentOrderDate
from Customers c join Orders o on c.CustomerID = o.CustomerID
group by c.ContactName

-- if list all customers with the most recent orde date which is 1998-05-06
select c.ContactName,o.OrderDate
from Customers c join Orders o on c.CustomerID = o.CustomerID
where o.OrderDate in (select top 1 o.OrderDate 
                        from Orders o 
                        order by o.OrderDate desc) 

-- 21.  Display the names of all customers  along with the  count of products they bought
select c.ContactName, count(od.ProductID) as ProductsCount
from Customers c join Orders o on c.CustomerID = o.CustomerID join [Order Details] od on o.OrderID = od.OrderID
group by c.ContactName;

-- 22.  Display the customer ids who bought more than 100 Products with count of products.
select c.ContactName
from Customers c join Orders o on c.CustomerID = o.CustomerID join [Order Details] od on o.OrderID = od.OrderID
group by c.ContactName
having count(od.ProductID) > 100;

-- 23.  List all of the possible ways that suppliers can ship their products. Display the results as below
--     Supplier Company Name                Shipping Company Name
--     ---------------------------------            ----------------------------------
select su.CompanyName as [Supplier Company Name], sh.CompanyName as [Shipping Company Name]
from Suppliers su cross join Shippers sh;

-- 24.  Display the products order each day. Show Order date and Product Name.
select o.OrderDate, p.ProductName
from Orders o join [Order Details] as od on o.OrderID = od.OrderID join Products p on od.ProductID = p.ProductID
group by o.OrderDate, p.ProductName;

-- 25.  Displays pairs of employees who have the same job title.
select e1.EmployeeID as Employee1, e2.EmployeeID as Employee2, e1.Title
from Employees e1 join Employees e2 on e1.Title = e2.Title and e1.EmployeeID < e2.EmployeeID;

-- 26.  Display all the Managers who have more than 2 employees reporting to them.
select m.EmployeeID as ManagerID, m.LastName + ' ' + m.FirstName as ManagerName
from Employees m join Employees e on m.EmployeeID = e.ReportsTo
group by m. EmployeeID, m.LastName, m.FirstName
having count(e.EmployeeID) > 2;

-- Alternatively
-- select EmployeeID as ManagerID, LastName + ' ' + FirstName as ManagerName
-- from Employees
-- where EmployeeID in (
-- select ReportsTo
-- from Employees e
-- group by ReportsTo
-- having count(*) > 2);


-- 27.  Display the customers and suppliers by city. The results should have the following columns
-- City
-- Name
-- Contact Name,
-- Type (Customer or Supplier)
select City, CompanyName as Name, ContactName, 'Customer' as Type
from Customers 
Union
select City, CompanyName as Name, ContactName, 'Supplier' as Type
from Suppliers;
GO