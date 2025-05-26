1️⃣ What are the LIMIT and OFFSET clauses used for?
LIMIT and OFFSET are used to control the number of rows returned by a SQL query.

LIMIT specifies how many rows you want to return.

OFFSET tells the database to skip a specific number of rows before starting to return results.

🔹 Example:
sql
Copy code
SELECT * FROM sightings
LIMIT 10 OFFSET 5;
👉 This query returns 10 rows, starting after skipping the first 5.

2️⃣ How can you modify data using UPDATE statements?
The UPDATE statement is used to change existing records in a table.

🔹 Syntax:
sql
Copy code
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
🔹 Example:
sql
Copy code
UPDATE rangers
SET region = 'Eastern Zone'
WHERE ranger_id = 3;
👉 This updates the region field to "Eastern Zone" for the ranger with ID 3.

⚠️ Note: Always use WHERE to avoid updating all rows by mistake.

3️⃣ What is the significance of the JOIN operation, and how does it work in PostgreSQL?
JOIN is used to combine rows from two or more tables based on a related column between them.

It allows you to pull related data together for meaningful analysis.

🔹 Common Types of JOINs:
INNER JOIN: Returns matching rows in both tables.

LEFT JOIN: Returns all rows from the left table, even if there’s no match in the right table.

RIGHT JOIN: Returns all rows from the right table, even if there’s no match in the left.

FULL JOIN: Returns all rows when there is a match in one of the tables.

🔹 Example:
sql
Copy code
SELECT r.name, s.location
FROM rangers r
JOIN sightings s ON r.ranger_id = s.ranger_id;
👉 This retrieves the ranger names and the locations of their sightings.

4️⃣ Explain the GROUP BY clause and its role in aggregation operations.
GROUP BY is used to group rows that have the same values in specified columns into summary rows.

It is often used with aggregate functions like COUNT(), SUM(), AVG(), etc.

🔹 Example:
sql
Copy code
SELECT ranger_id, COUNT(*) AS total_sightings
FROM sightings
GROUP BY ranger_id;
👉 This groups the sightings by ranger_id and counts how many sightings each ranger made.

5️⃣ How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
These functions operate on sets of values and return a single value.

🔹 Examples:
sql
Copy code
-- Count total sightings
SELECT COUNT(*) FROM sightings;

-- Sum of sightings per ranger
SELECT ranger_id, COUNT(*) FROM sightings GROUP BY ranger_id;

-- Average number of sightings per ranger
SELECT AVG(total)
FROM (
  SELECT COUNT(*) AS total
  FROM sightings
  GROUP BY ranger_id
) AS subquery;
✅ These are essential for summarizing and analyzing data in your PostgreSQL database.