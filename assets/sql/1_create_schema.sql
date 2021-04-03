CREATE TABLE encounter
(
    id              INTEGER PRIMARY KEY,
    ownSeed         TEXT,
    encounterSeed   TEXT,
    latitude        FLOAT,
    longitude       FLOAT,
    startDate       INT,
    endDate         INT,
    averageDistance INT,
    transmitted     INT
);