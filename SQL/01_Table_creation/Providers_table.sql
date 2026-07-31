
CREATE TABLE Providers (
    provider_id VARCHAR(10) PRIMARY KEY,
    provider_name VARCHAR(100),
    specialty VARCHAR(50),
    facility_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(30),
    network_status VARCHAR(20)
);