-- Comments: "-- " and "/*___*/"

USE spj; -- "use" is used to select database.
-- ==== Query questions ==== --

-- 1. Get Full details of all projects.
SELECT * FROM project; -- "select" query is used to select or fetch data from the particular database.table

-- 2. Get Full details of all projects in London.
SELECT * FROM project
         WHERE CITY="LONDON"; -- "where" is used to filter records returned by select.

-- 3. Get supplier numbers for suppliers who supply projects J1.
SELECT SNO FROM shipment
           WHERE JNO="J1";

-- 4. Get all shipments where the quantity is in the range 300 to 750 inclusive.
SELECT * FROM shipment
         WHERE QTY BETWEEN 300 AND 750; -- "between" operator selects values within a given range.
                                        -- AND, OR, and NOT are logical operators

/* 5. Get all part-color/part-city pairs.
   Note : Here and subsequently, the terms “all” means “all currently represented in the database, “ not “all possible”
*/
SELECT CONCAT_WS("-", PNAME, COLOR) AS "part-color",
       CONCAT_WS("-", PNAME, CITY) AS "part-city" FROM part;
-- or
SELECT CONCAT_WS("\t",
    CONCAT(PNAME, "-", COLOR),
    CONCAT(PNAME, "-", CITY)
    ) AS columnName FROM part;
-- "concat" function is used concatenate strings (outputs)
-- "concat_ws" function is used to concatenate strings (outputs) with a specified character.
-- "as" is used to give alias (a temporary name)

/* 6 Get all supplier -number/part- number/project- number triples such that the indicated supplier, part and
    project are all collocated (i.e. all in the same city). output: https://prnt.sc/RZkLL_qFr9_U */
-- for above we have to specify a inner join as we want the same/common data from different tables.
SELECT CONCAT_WS("->", s.SNO, p.PNO, j.JNO) AS columnName, s.CITY
FROM supplier AS s
     JOIN part AS p
     JOIN project AS j ON p.CITY = j.CITY AND j.CITY = s.CITY;
-- OR
SELECT CONCAT_WS("->", s.SNO, p.PNO, j.JNO) AS columnName,
       s.CITY AS supplierCity,
       p.CITY AS partCity,
       j.CITY AS projectCity
FROM supplier AS s,
     part AS p,
     project AS j
WHERE s.CITY=p.CITY AND p.CITY=j.CITY  AND s.CITY = j.CITY;
-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.

/* 7.  Get all supplier -number/part- number/project- number triples such that the indicated supplier, part
and project are not all collocated. output: https://prnt.sc/FVrRIegH5gLh */
SELECT CONCAT_WS("->", s.SNO, p.PNO, j.JNO) AS columnName,
       s.CITY AS supplierCity,
       p.CITY AS partCity,
       j.CITY AS projectCity
FROM supplier AS s,
     part AS p,
     project AS j
WHERE NOT (s.CITY=p.CITY AND p.CITY=j.CITY AND s.CITY = j.CITY);
-- OR
SELECT CONCAT_WS(" -> ", s.SNO, p.PNO, j.JNO) AS columnName,
       s.CITY AS supplierCity,
       p.CITY AS partCity,
       j.CITY AS projectCity
FROM supplier AS s
     JOIN part AS p
     JOIN project AS j ON NOT (p.CITY = j.CITY AND j.CITY = s.CITY AND s.CITY = j.CITY);

/* 8. Get all supplier -number/part- number/project- number triples such that no two of the indicated
supplier, part and project are collocated. */
SELECT CONCAT_WS(" -> ", s.SNO, p.PNO, j.JNO) AS columnName,
       s.CITY AS supplierCity,
       p.CITY AS partCity,
       j.CITY AS projectCity
FROM supplier AS s
    JOIN part AS p
    JOIN project j ON NOT s.CITY = p.CITY AND NOT p.CITY = j.CITY AND NOT s.CITY = j.CITY;
-- OR
SELECT CONCAT_WS(" -> ", s.SNO, p.PNO, j.JNO) AS columnName,
       s.CITY AS supplierCity,
       p.CITY AS partCity,
       j.CITY AS projectCity
FROM supplier AS s,
    part AS p,
    project j
WHERE NOT s.CITY = p.CITY AND NOT p.CITY = j.CITY AND NOT s.CITY = j.CITY;

-- 9. Get full details for parts supplied by the supplier in the London.
SELECT * FROM part WHERE CITY="London";

-- 10. Get part numbers for parts supplied by a supplier in London to a project in London.
SELECT DISTINCT part.PNO-- , part.CITY, p.CITY
FROM part
LEFT JOIN project p on part.CITY = p.CITY WHERE p.CITY="LONDON"
ORDER BY part.PNO;
-- DISTINCT keyword is used to filter the repeated data rows
-- ORDER BY is used sort data in ascending or descending with respect to specified column. default is ASC, can use DESC.

-- 11. Get all pairs of city names such that a supplier in the first city supplies a project in the second city.


-- 15. Get the total number of projects supplied by supplier S1.
SELECT SNO, COUNT(JNO) AS totalNumProjects
FROM shipment
WHERE SNO="S1"
GROUP BY SNO;
-- COUNT() function returns the number of records returned by a select query
-- The GROUP BY statement groups rows that have the same values into summary rows, often used with aggregate functions
-- to group the result-set by one or more columns.

-- 16. Get the total quantity of part P1 supplied by supplier S1.
SELECT SNO, PNO, SUM(QTY) totalQuantity
FROM shipment
WHERE SNO="S1" AND PNO="P1"
GROUP BY SNO;
-- SUM function is used sum the values of select query

--
