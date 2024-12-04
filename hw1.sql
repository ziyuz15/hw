-- 1.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter. 
select ProductID, Name, Color, ListPrice
from Production.Product;

-- 2.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, excludes the rows that ListPrice is 0.
select ProductID, Name, Color, ListPrice
from Production.Product
where ListPrice <> 0;

-- 3.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column.
select ProductID, Name, Color, ListPrice
from Production.Product
where Color IS NULL;

-- 4.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
select ProductID, Name, Color, ListPrice
from Production.Product
where Color IS NOT NULL;

-- 5.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is not NULL and ListPrice > 0;

-- 6.Write a query that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
select Name + '-' + Color as NameColor
from Production.Product
where Color IS NOT NULL;

-- 7.Write a query that generates the following result set  from Production.Product:
-- NAME: LL Crankarm  --  COLOR: Black
-- NAME: ML Crankarm  --  COLOR: Black
-- NAME: HL Crankarm  --  COLOR: Black
-- NAME: Chainring Bolts  --  COLOR: Silver
-- NAME: Chainring Nut  --  COLOR: Silver
-- NAME: Chainring  --  COLOR: Black
select 'NAME: ' + Name + '  --  COLOR: ' + Color as Result
from Production.Product
where name like '%Crankarm' or Name like 'Chainring%'
order by name desc;

-- 8.Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
select ProductID, Name
from Production.Product
where ProductID between 400 and 500;

-- 9.Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue
select ProductID, Name, Color
from Production.Product
where Color in ('Black', 'Blue');

-- 10.Write a query to get a result set on products that begins with the letter S. 
select Name
from Production.Product
where Name like 'S%';

-- 11.Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
-- Name                                               ListPrice
-- Seat Lug                                              0,00
-- Seat Post                                             0,00
-- Seat Stays                                            0,00
-- Seat Tube                                            0,00
-- Short-Sleeve Classic Jersey, L           53,99
-- Short-Sleeve Classic Jersey, M          53,99
select Top 7 Name, ListPrice
from Production.Product
where Name like 'S%' and ListPrice in (0.00, 53.99)
order by name;

-- 12.Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
-- Name                                               ListPrice
-- Adjustable Race                                   0,00
-- All-Purpose Bike Stand                       159,00
-- AWC Logo Cap                                      8,99
-- Seat Lug                                                 0,00
-- Seat Post                                                0,00
select Top 5 Name, ListPrice
from Production.Product
where Name like 'S%' or Name like 'A%' 
order by name;

-- 13. Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
select Name
from Production.Product
where Name like 'SPO[^k]%'
order by name;

-- 14. Write a query that retrieves unique colors from the table Production.Product. Order the results in descending  manner.
select distinct color
from Production.Product
order by color desc;