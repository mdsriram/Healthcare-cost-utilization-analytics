CREATE TABLE Admissions (
    admission_id VARCHAR(10) PRIMARY KEY,
    member_id INT,
    provider_id VARCHAR(10),
    admission_date DATE,
    discharge_date DATE,
    diagnosis_code VARCHAR(10),
    drg_code VARCHAR(20),
    drg_weight DECIMAL(5,2),
    admission_type VARCHAR(20),
    discharge_status VARCHAR(20),
    paid_amount DECIMAL(10,2),

    FOREIGN KEY (member_id)
        REFERENCES Members(member_id),

    FOREIGN KEY (provider_id)
        REFERENCES Providers(provider_id)
);