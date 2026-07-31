
CREATE TABLE HCC_Mapping (
    diagnosis_code VARCHAR(10) PRIMARY KEY,
    diagnosis_name VARCHAR(100),
    hcc_category VARCHAR(50),
    risk_weight DECIMAL(4,2)
);