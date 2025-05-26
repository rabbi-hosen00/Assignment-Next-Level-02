
-- Table rangers
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

SELECT  from rangers;
-- Table species
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) DEFAULT 'Unknown'
);

-- Table sightings
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers (ranger_id) ON DELETE CASCADE,
    species_id INT REFERENCES species (species_id) ON DELETE CASCADE,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes TEXT
);

-- Sample data for rangers
INSERT INTO
    rangers (ranger_id, name, region)
VALUES (
        1,
        'Alice Green',
        'Northern Hills'
    ),
    (2, 'Bob White', 'River Delta'),
    (
        3,
        'Carol King',
        'Mountain Range'
    );

-- Sample data for species
INSERT INTO
    species (
        species_id,
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        1,
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        2,
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        3,
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        4,
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

-- Sample data for sightings
INSERT INTO
    sightings (
        sighting_id,
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        1,
        'Peak Ridge',
        '2024-05-10 074500',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        2,
        'Bankwood Area',
        '2024-05-12 162000',
        'Juvenile seen'
    ),
    (
        3,
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 091000',
        'Feeding observed'
    ),
    (
        4,
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 183000',
        NULL
    );

-- Problem 1 Register a new ranger
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');
SELECT  from rangers;

-- Problem 2 Count unique species ever sighted
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

SELECT  from species;

-- Problem 3 Find all sightings with location including Pass
SELECT 
FROM sightings
WHERE location ILIKE '%Pass%';


-- Problem 4 Each ranger's total number of sightings
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
    LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY
    r.name;

-- Problem 5 Species never sighted
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT DISTINCT
            species_id
        FROM sightings
    );

-- Problem 6 Most recent 2 sightings
SELECT sp.common_name, s.sighting_time, r.name
FROM
    sightings s
    JOIN species sp ON s.species_id = sp.species_id
    JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- Problem 7 Update species discovered before 1800
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date  '1800-01-01';

-- Problem 8 Label sighting time of day
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        )  12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        )  17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- Problem 9 Delete rangers who have never sighted any species
DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT DISTINCT
            ranger_id
        FROM sightings
    );








