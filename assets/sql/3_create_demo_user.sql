INSERT INTO user (provinceId, uuid, date, deleted) VALUES (1, 'c6c58fa2-b94a-11eb-8529-0242ac130003', 1622741114962, 0);

INSERT INTO encounter_seed (userId, seedUuid, date, deleted) VALUES (1, 'b641ac96-b946-11eb-8529-0242ac130003', 1622741114962, 0);

INSERT INTO encounter (ownSeedId, encounterSeedUuid, latitude, longitude, date, distance, duration, transmitted) VALUES (1, '96ab2600-b946-11eb-8529-0242ac130003', 40.494220, -3.658509, 1621494000000, 0.50, 0, 0);

INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab1fd4-b946-11eb-8529-0242ac130003', 'b641a908-b946-11eb-8529-0242ac130003', 40.399902, -3.695834, 1622741114962, 150, 0);
INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab21fa-b946-11eb-8529-0242ac130003', 'b641b04c-b946-11eb-8529-0242ac130003', 40.395718, -3.702827, 1622741114962, 180, 0);
INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab2470-b946-11eb-8529-0242ac130003', 'b641ab9c-b946-11eb-8529-0242ac130003', 40.442505, -3.692521, 1622741114962, 1020, 0);
INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab2542-b946-11eb-8529-0242ac130003', 'b641b0f6-b946-11eb-8529-0242ac130003', 40.394673, -3.671564, 1622741114962, 310, 0);
INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab2600-b946-11eb-8529-0242ac130003', 'b641ac96-b946-11eb-8529-0242ac130003', 40.494220, -3.658509, 1622741114962, 300, 0);
INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab26b4-b946-11eb-8529-0242ac130003', 'b641b1aa-b946-11eb-8529-0242ac130003', 43.306232, -1.895585, 1622741114962, 300, 0);
INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab275e-b946-11eb-8529-0242ac130003', 'b641aec6-b946-11eb-8529-0242ac130003', 43.307864, -1.895349, 1622741114962, 310, 0);
INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab2808-b946-11eb-8529-0242ac130003', 'b641b25e-b946-11eb-8529-0242ac130003', 43.308528, -1.893525, 1622741114962, 315, 0);
INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab28bc-b946-11eb-8529-0242ac130003', 'b641af8e-b946-11eb-8529-0242ac130003', 43.307278, -1.892087, 1622741114962, 350, 0);
INSERT INTO risk_encounter (riskSeedUuid, encounterSeedUuid, latitude, longitude, date, duration, deleted) VALUES ('96ab2a92-b946-11eb-8529-0242ac130003', 'b641b47a-b946-11eb-8529-0242ac130003', 43.310581, -1.896326, 1622741114962, 500, 0);

INSERT INTO evolution (totalCases, date, deleted) VALUES (20, 1622671200000, 0);
INSERT INTO evolution (totalCases, date, deleted) VALUES (10, 1622584800000, 0);
INSERT INTO evolution (totalCases, date, deleted) VALUES (35, 1622498400000, 0);
INSERT INTO evolution (totalCases, date, deleted) VALUES (45, 1622412000000, 0);
INSERT INTO evolution (totalCases, date, deleted) VALUES (65, 1622325600000, 0);
INSERT INTO evolution (totalCases, date, deleted) VALUES (55, 1622239200000, 0);
INSERT INTO evolution (totalCases, date, deleted) VALUES (35, 1622152800000, 0);
INSERT INTO evolution (totalCases, date, deleted) VALUES (25, 1622066400000, 0);
INSERT INTO evolution (totalCases, date, deleted) VALUES (15, 1621980000000, 0);

INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (1, 20, 1622671200000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (1, 10, 1622584800000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (1, 35, 1622498400000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (1, 45, 1622412000000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (1, 65, 1622325600000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (2, 5, 1622671200000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (2, 1, 1622584800000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (2, 3, 1622498400000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (2, 4, 1622412000000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (2, 6, 1622325600000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (3, 4, 1622671200000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (3, 12,1622584800000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (3, 25,1622498400000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (3, 23,1622412000000, 0);
INSERT INTO evolution_province (provinceId, totalCases, date, deleted) VALUES (3, 5, 1622325600000, 0);