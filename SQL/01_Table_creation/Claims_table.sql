
CREATE TABLE Claims (
    claim_id VARCHAR(10) PRIMARY KEY,
    member_id INT,
    claim_date DATE,
    provider_id VARCHAR(10),
    claim_type VARCHAR(10),
    diagnosis_code VARCHAR(10),
    procedure_code VARCHAR(10),
    billed_amount DECIMAL(10,2),
    paid_amount DECIMAL(10,2),
    claim_status VARCHAR(20),

    FOREIGN KEY (member_id)
        REFERENCES Members(member_id),

    FOREIGN KEY (provider_id)
        REFERENCES Providers(provider_id)
);