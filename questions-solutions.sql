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
     JOIN part AS p ON s.CITY = p.CITY
     JOIN project AS j ON p.CITY = j.CITY;
-- OR
SELECT CONCAT_WS("->", s.SNO, p.PNO, j.JNO) AS columnName, s.CITY
FROM supplier AS s,
     part AS p,
     project AS j
WHERE s.CITY=p.CITY AND p.CITY=j.CITY;
-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.
