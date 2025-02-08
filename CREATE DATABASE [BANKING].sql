CREATE DATABASE [BANKING]
GO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE [BANKING]

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE CENTRALS
(
    id_central INT PRIMARY KEY IDENTITY(1,1),
    name_central NVARCHAR(100) NOT NULL,
    address_central NVARCHAR(100) NOT NULL,
    phone_central NVARCHAR(20) NOT NULL,
    email_central NVARCHAR(100) NOT NULL,
    CREATED_DATE DATETIME NOT NULL,
    UPDATED_DATE DATETIME NOT NULL
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CREATE TABLE BRANCHES
CREATE TABLE BRANCHES
(
    id_branch INT PRIMARY KEY IDENTITY(1,1),
    code_branch NVARCHAR(10) UNIQUE NOT NULL,
    name_branch NVARCHAR(100) NOT NULL,
    address_branch NVARCHAR(100) NOT NULL,
    phone_branch NVARCHAR(20) NOT NULL,
    email_branch NVARCHAR(100) NOT NULL,
    id_central_branch INT NOT NULL, --FOREIGN KEY REFERENCES CENTRALS
    CREATED_DATE DATETIME NOT NULL,
    UPDATED_DATE DATETIME NOT NULL,
    FOREIGN KEY (id_central_branch) REFERENCES CENTRALS(id_central) --FOREIGN KEY REFERENCES CENTRALS
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CREATE TABLE ATMS
CREATE TABLE ATMS
(
    id_atm INT PRIMARY KEY IDENTITY(1,1),
    code_atm NVARCHAR(10) UNIQUE NOT NULL,
    name_atm NVARCHAR(100) NOT NULL,
    address_atm NVARCHAR(100) NOT NULL,
    phone_atm NVARCHAR(20) NOT NULL,
    email_atm NVARCHAR(100) NOT NULL,
    id_branch_atm INT NOT NULL, --FOREIGN KEY REFERENCES BRANCHES
    CREATED_DATE DATETIME NOT NULL,
    UPDATED_DATE DATETIME NOT NULL,
    FOREIGN KEY (id_branch_atm) REFERENCES BRANCHES(id_branch) --FOREIGN KEY REFERENCES BRANCHES
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CREATE TABLE ACCOUNTS HOLDERS
CREATE TABLE ACCOUNTS_HOLDERS
(
    id_account_holder INT PRIMARY KEY IDENTITY(1,1),
    name_account_holder NVARCHAR(100) NOT NULL,
    address_account_holder NVARCHAR(100) NOT NULL,
    phone_account_holder NVARCHAR(20) NOT NULL,
    email_account_holder NVARCHAR(100) NOT NULL,
    CREATED_DATE DATETIME NOT NULL,
    UPDATED_DATE DATETIME NOT NULL
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CREATE TABLE ACCOUNTS
CREATE TABLE ACCOUNTS
(
    id_account INT PRIMARY KEY IDENTITY(1,1),
    number_account NVARCHAR(10) UNIQUE NOT NULL,
    type_account NVARCHAR(10) CHECK (type_account IN ('AHORRO', 'MONETARIA')),
    currency_account NVARCHAR(10) CHECK(currency_account IN ('USD', 'GTQ')),
    balance_account DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    id_account_holder_account INT NOT NULL, --FOREIGN KEY REFERENCES ACCOUNTS HOLDERS
    id_branch_account INT NOT NULL, --FOREIGN KEY REFERENCES BRANCHES
    CREATED_DATE DATETIME NOT NULL,
    UPDATED_DATE DATETIME NOT NULL,
    FOREIGN KEY (id_account_holder_account) REFERENCES ACCOUNTS_HOLDERS(id_account_holder), --FOREIGN KEY REFERENCES ACCOUNTS HOLDERS
    FOREIGN KEY (id_branch_account) REFERENCES BRANCHES(id_branch) --FOREIGN KEY REFERENCES BRANCHES
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CREATE TABLE TRANSACTIONS
CREATE TABLE TRANSACTIONS
(
    id_transaction INT PRIMARY KEY IDENTITY(1,1),
    type_transaction NVARCHAR(10) CHECK(type_transaction IN ('DEPOSITO', 'RETIRO')),
    amount_transaction DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    id_account_transaction INT NOT NULL, --FOREIGN KEY REFERENCES ACCOUNTS
    id_atm_transaction INT NOT NULL, --FOREIGN KEY REFERENCES ATMS
    CREATED_DATE DATETIME NOT NULL,
    UPDATED_DATE DATETIME NOT NULL,
    FOREIGN KEY (id_account_transaction) REFERENCES ACCOUNTS(id_account), --FOREIGN KEY REFERENCES ACCOUNTS
    FOREIGN KEY (id_atm_transaction) REFERENCES ATMS(id_atm) --FOREIGN KEY REFERENCES ATMS
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO CENTRALS (name_central, address_central, phone_central, email_central, CREATED_DATE, UPDATED_DATE)
VALUES 
('Central Bank Guatemala', '6a Ave 3-45 Zona 10', '502-2412-1234', 'info@centralbankgt.com', '2023-01-15', '2023-01-15'),
('Central Bank Honduras', 'Colonia Alameda, Tegucigalpa', '504-2256-7890', 'contacto@bch.hn', '2023-02-20', '2023-02-20'),
('Banco Central El Salvador', 'Av. Revolución, San Salvador', '503-2524-9100', 'info@bcesv.com', '2023-03-10', '2023-03-10'),
('Banco Central de Panamá', 'Paseo de las Bóvedas, Panamá', '507-3030-4567', 'contacto@bcpanama.com', '2023-04-05', '2023-04-05'),
('Central Bank Costa Rica', 'Avenida Central, San José', '506-2253-5500', 'informes@bccr.fi.cr', '2023-05-25', '2023-05-25'),
('Banco Central Nicaragua', 'Edificio BICSA, Managua', '505-2220-0010', 'info@bcn.gob.ni', '2023-06-12', '2023-06-12'),
('Central Bank Belize', 'Queen St, Belize City', '501-223-0800', 'info@centralbankbelize.org', '2023-07-22', '2023-07-22'),
('Banco Central Republica Dominicana', 'Av. Winston Churchill, Santo Domingo', '809-549-2777', 'contacto@bcrd.gov.do', '2023-08-17', '2023-08-17'),
('Banco de Guatemala', 'Avenida de la Reforma 4-60', '502-2314-4321', 'contacto@banrural.com.gt', '2023-09-30', '2023-09-30'),
('Banco Central de Panamá', 'Avenida Balboa, Panamá', '507-227-4532', 'info@bcpanama.com', '2023-10-01', '2023-10-01');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO BRANCHES (code_branch, name_branch, address_branch, phone_branch, email_branch, id_central_branch, CREATED_DATE, UPDATED_DATE)
VALUES
('BR001', 'Sucursal Principal', '6a Ave 3-45 Zona 10', '502-2412-1234', 'sucursal@centralbankgt.com', 1, '2023-01-15', '2023-01-15'),
('BR002', 'Sucursal Tegucigalpa', 'Colonia Alameda', '504-2256-7890', 'sucursal@bch.hn', 2, '2023-02-20', '2023-02-20'),
('BR003', 'Sucursal San Salvador', 'Av. Revolución', '503-2524-9100', 'sucursal@bcesv.com', 3, '2023-03-10', '2023-03-10'),
('BR004', 'Sucursal Panamá', 'Paseo de las Bóvedas', '507-3030-4567', 'sucursal@bcpanama.com', 4, '2023-04-05', '2023-04-05'),
('BR005', 'Sucursal San José', 'Avenida Central', '506-2253-5500', 'sucursal@bccr.fi.cr', 5, '2023-05-25', '2023-05-25'),
('BR006', 'Sucursal Managua', 'Edificio BICSA', '505-2220-0010', 'sucursal@bcn.gob.ni', 6, '2023-06-12', '2023-06-12'),
('BR007', 'Sucursal Belize City', 'Queen St', '501-223-0800', 'sucursal@centralbankbelize.org', 7, '2023-07-22', '2023-07-22'),
('BR008', 'Sucursal Santo Domingo', 'Av. Winston Churchill', '809-549-2777', 'sucursal@bcrd.gov.do', 8, '2023-08-17', '2023-08-17'),
('BR009', 'Sucursal Guatemala', 'Avenida de la Reforma', '502-2314-4321', 'sucursal@banrural.com.gt', 9, '2023-09-30', '2023-09-30'),
('BR010', 'Sucursal Panamá 2', 'Avenida Balboa', '507-227-4532', 'sucursal@bcpanama.com', 10, '2023-10-01', '2023-10-01');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO ATMS (code_atm, name_atm, address_atm, phone_atm, email_atm, id_branch_atm, CREATED_DATE, UPDATED_DATE)
VALUES
('ATM001', 'ATM Sucursal Principal', '6a Ave 3-45 Zona 10', '502-2412-1234', 'atm@centralbankgt.com', 1, '2023-01-15', '2023-01-15'),
('ATM002', 'ATM Tegucigalpa', 'Colonia Alameda', '504-2256-7890', 'atm@bch.hn', 2, '2023-02-20', '2023-02-20'),
('ATM003', 'ATM San Salvador', 'Av. Revolución', '503-2524-9100', 'atm@bcesv.com', 3, '2023-03-10', '2023-03-10'),
('ATM004', 'ATM Panamá', 'Paseo de las Bóvedas', '507-3030-4567', 'atm@bcpanama.com', 4, '2023-04-05', '2023-04-05'),
('ATM005', 'ATM San José', 'Avenida Central', '506-2253-5500', 'atm@bccr.fi.cr', 5, '2023-05-25', '2023-05-25'),
('ATM006', 'ATM Managua', 'Edificio BICSA', '505-2220-0010', 'atm@bcn.gob.ni', 6, '2023-06-12', '2023-06-12'),
('ATM007', 'ATM Belize City', 'Queen St', '501-223-0800', 'atm@centralbankbelize.org', 7, '2023-07-22', '2023-07-22'),
('ATM008', 'ATM Santo Domingo', 'Av. Winston Churchill', '809-549-2777', 'atm@bcrd.gov.do', 8, '2023-08-17', '2023-08-17'),
('ATM009', 'ATM Guatemala', 'Avenida de la Reforma', '502-2314-4321', 'atm@banrural.com.gt', 9, '2023-09-30', '2023-09-30'),
('ATM010', 'ATM Panamá 2', 'Avenida Balboa', '507-227-4532', 'atm@bcpanama.com', 10, '2023-10-01', '2023-10-01');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO ACCOUNTS_HOLDERS (name_account_holder, address_account_holder, phone_account_holder, email_account_holder, CREATED_DATE, UPDATED_DATE)
VALUES
('Carlos Pérez', '6a Ave 3-45 Zona 10, Ciudad', '502-2412-1234', 'carlos.perez@example.com', '2023-01-15', '2023-01-15'),
('Ana López', 'Colonia Alameda, Tegucigalpa', '504-2256-7890', 'ana.lopez@example.com', '2023-02-20', '2023-02-20'),
('Luis Rodríguez', 'Av. Revolución, San Salvador', '503-2524-9100', 'luis.rodriguez@example.com', '2023-03-10', '2023-03-10'),
('José Martínez', 'Paseo de las Bóvedas, Panamá', '507-3030-4567', 'jose.martinez@example.com', '2023-04-05', '2023-04-05'),
('María González', 'Avenida Central, San José', '506-2253-5500', 'maria.gonzalez@example.com', '2023-05-25', '2023-05-25'),
('Francisco Díaz', 'Edificio BICSA, Managua', '505-2220-0010', 'francisco.diaz@example.com', '2023-06-12', '2023-06-12'),
('Luisa Ramírez', 'Queen St, Belize City', '501-223-0800', 'luisa.ramirez@example.com', '2023-07-22', '2023-07-22'),
('Roberto Fernández', 'Av. Winston Churchill, Santo Domingo', '809-549-2777', 'roberto.fernandez@example.com', '2023-08-17', '2023-08-17'),
('Patricia Torres', 'Avenida de la Reforma, Ciudad', '502-2314-4321', 'patricia.torres@example.com', '2023-09-30', '2023-09-30'),
('Ricardo Pérez', 'Avenida Balboa, Panamá', '507-227-4532', 'ricardo.perez@example.com', '2023-10-01', '2023-10-01');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO ACCOUNTS (number_account, type_account, currency_account, balance_account, id_account_holder_account, id_branch_account, CREATED_DATE, UPDATED_DATE)
VALUES
('100001', 'AHORRO', 'USD', 1500.00, 1, 1, '2023-01-15', '2023-01-15'),
('100002', 'MONETARIA', 'GTQ', 2000.00, 2, 2, '2023-02-20', '2023-02-20'),
('100003', 'AHORRO', 'USD', 2500.00, 3, 3, '2023-03-10', '2023-03-10'),
('100004', 'MONETARIA', 'GTQ', 3000.00, 4, 4, '2023-04-05', '2023-04-05'),
('100005', 'AHORRO', 'USD', 3500.00, 5, 5, '2023-05-25', '2023-05-25'),
('100006', 'MONETARIA', 'GTQ', 4000.00, 6, 6, '2023-06-12', '2023-06-12'),
('100007', 'AHORRO', 'USD', 4500.00, 7, 7, '2023-07-22', '2023-07-22'),
('100008', 'MONETARIA', 'GTQ', 5000.00, 8, 8, '2023-08-17', '2023-08-17'),
('100009', 'AHORRO', 'USD', 5500.00, 9, 9, '2023-09-30', '2023-09-30'),
('100010', 'MONETARIA', 'GTQ', 6000.00, 10, 10, '2023-10-01', '2023-10-01');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO TRANSACTIONS (type_transaction, amount_transaction, id_account_transaction, id_atm_transaction, CREATED_DATE, UPDATED_DATE)
VALUES
('DEPOSITO', 1000.00, 1, 1, '2023-01-15', '2023-01-15'),
('RETIRO', 500.00, 2, 2, '2023-02-20', '2023-02-20'),
('DEPOSITO', 1200.00, 3, 3, '2023-03-10', '2023-03-10'),
('RETIRO', 800.00, 4, 4, '2023-04-05', '2023-04-05'),
('DEPOSITO', 1500.00, 5, 5, '2023-05-25', '2023-05-25'),
('RETIRO', 600.00, 6, 6, '2023-06-12', '2023-06-12'),
('DEPOSITO', 1800.00, 7, 7, '2023-07-22', '2023-07-22'),
('RETIRO', 700.00, 8, 8, '2023-08-17', '2023-08-17'),
('DEPOSITO', 2000.00, 9, 9, '2023-09-30', '2023-09-30'),
('RETIRO', 900.00, 10, 10, '2023-10-01', '2023-10-01');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT * 
FROM CENTRALS;

SELECT * 
FROM BRANCHES;

SELECT * 
FROM ATMS;

SELECT * 
FROM ACCOUNTS_HOLDERS;

SELECT * 
FROM ACCOUNTS;

SELECT * 
FROM TRANSACTIONS;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Índices para mejorar el rendimiento
CREATE INDEX idx_branches_central ON BRANCHES(id_central_branch);
CREATE INDEX idx_atms_branch ON ATMS(id_branch_atm);
CREATE INDEX idx_accounts_holder ON ACCOUNTS(id_account_holder_account);
CREATE INDEX idx_accounts_branch ON ACCOUNTS(id_branch_account);
CREATE INDEX idx_transactions_account ON Transactions(id_account_transaction);
CREATE INDEX idx_transactions_atm ON Transactions(id_atm_transaction);


SELECT b.name_branch, c.name_central
FROM BRANCHES b
INNER JOIN CENTRALS c ON b.id_central_branch = c.id_central;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- Índices para búsquedas frecuentes
CREATE INDEX idx_central_name ON CENTRALS(name_central);
CREATE INDEX idx_branch_code ON BRANCHES(code_branch);
CREATE INDEX idx_account_number ON ACCOUNTS(number_account);
CREATE INDEX idx_account_holder_name ON ACCOUNTS_HOLDERS(name_account_holder);
CREATE INDEX idx_transaction_type ON Transactions(type_transaction);


-- Consulta que busca una cuenta por su número
SELECT * FROM ACCOUNTS WHERE number_account = '1234567890';

-- Consulta que filtra transacciones por tipo
SELECT * FROM Transactions WHERE type_transaction = 'DEPOSITO';


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Vista para obtener información detallada de cuentas con sus titulares
CREATE VIEW AccountDetails AS
SELECT 
    a.id_account,
    a.number_account,
    a.type_account,
    a.currency_account,
    a.balance_account,
    ah.name_account_holder,
    ah.email_account_holder,
    b.name_branch AS branch_name
FROM 
    ACCOUNTS a
    INNER JOIN ACCOUNTS_HOLDERS ah ON a.id_account_holder_account = ah.id_account_holder
    INNER JOIN BRANCHES b ON a.id_branch_account = b.id_branch;

-- Seleccionar datos de la vista
SELECT * FROM AccountDetails;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Procedimiento para realizar un depósito
CREATE PROCEDURE DepositMoney
    @account_id INT,
    @amount DECIMAL(18, 2),
    @atm_id INT
AS
BEGIN
    BEGIN TRANSACTION;
    -- Actualizar el saldo de la cuenta
    UPDATE ACCOUNTS
    SET balance_account = balance_account + @amount
    WHERE id_account = @account_id;

    -- Registrar la transacción
    INSERT INTO Transactions (type_transaction, amount_transaction, id_account_transaction, id_atm_transaction, CREATED_DATE, UPDATED_DATE)
    VALUES ('DEPOSITO', @amount, @account_id, @atm_id, GETDATE(), GETDATE());

    COMMIT TRANSACTION;
END;

-- Ejecutar el procedimiento para depositar $100 en la cuenta con ID 1, usando el cajero con ID 1
EXEC DepositMoney @account_id = 1, @amount = 100.00, @atm_id = 1;

-- Verificar el saldo de la cuenta
SELECT * FROM ACCOUNTS WHERE id_account = 1;

-- Verificar la transacción registrada
SELECT * FROM Transactions WHERE id_account_transaction = 1;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Tabla de auditoría para ACCOUNTS
CREATE TABLE AuditAccounts
(
    id_audit INT PRIMARY KEY IDENTITY(1,1),
    id_account INT,
    old_balance DECIMAL(18,2),
    new_balance DECIMAL(18,2),
    change_date DATETIME,
    user_action NVARCHAR(50)
);

-- Trigger para auditar cambios en el saldo de las cuentas
CREATE TRIGGER trg_AuditAccountBalance
ON ACCOUNTS
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditAccounts (id_account, old_balance, new_balance, change_date, user_action)
    SELECT 
        i.id_account,
        d.balance_account AS old_balance,
        i.balance_account AS new_balance,
        GETDATE(),
        SYSTEM_USER
    FROM 
        inserted i
        INNER JOIN deleted d ON i.id_account = d.id_account;
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Crear una función de partición para la tabla Transactions
CREATE PARTITION FUNCTION TransactionDateRange (DATETIME)
AS RANGE RIGHT FOR VALUES ('2023-01-01', '2024-01-01');

-- Crear un esquema de partición
CREATE PARTITION SCHEME TransactionPartitionScheme
AS PARTITION TransactionDateRange
TO ([PRIMARY], [SECONDARY], [TERTIARY]);

-- Aplicar el esquema de partición a la tabla Transactions
CREATE TABLE Transactions
(
    id_transaction INT PRIMARY KEY IDENTITY(1,1),
    type_transaction NVARCHAR(10) CHECK(type_transaction IN ('DEPOSITO', 'RETIRO')),
    amount_transaction DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    id_account_transaction INT NOT NULL,
    id_atm_transaction INT NOT NULL,
    CREATED_DATE DATETIME NOT NULL DEFAULT GETDATE(),
    UPDATED_DATE DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_account_transaction) REFERENCES ACCOUNTS(id_account),
    FOREIGN KEY (id_atm_transaction) REFERENCES ATMS(id_atm)
) ON TransactionPartitionScheme(CREATED_DATE);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Compresión de Datos para Ahorrar Espacio 

ALTER TABLE Transactions REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE);

ALTER TABLE ACCOUNTS REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Optimización para Gran Escala
ALTER DATABASE BANKING SET READ_COMMITTED_SNAPSHOT ON;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Optimización de la Memoria del Servidor SQL
EXEC sp_configure 'show advanced options', 1;  
RECONFIGURE;  
EXEC sp_configure 'min server memory', 4096; 
EXEC sp_configure 'max server memory', 16384;  
RECONFIGURE;

--Optimización de Bloqueos con Snapshot Isolation
ALTER DATABASE BANKING  
SET ALLOW_SNAPSHOT_ISOLATION ON;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
