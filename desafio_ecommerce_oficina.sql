-- Criação do banco de dados
DROP DATABASE IF EXISTS OficinaDB;
CREATE DATABASE OficinaDB;
USE OficinaDB;

-- Tabela Cliente
DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    cpf_cnpj VARCHAR(20) UNIQUE,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL
);

-- Tabela Veiculo
DROP TABLE IF EXISTS Veiculo;
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    placa VARCHAR(10) UNIQUE,
    ano YEAR,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Ordem de Serviço
CREATE TABLE OrdemServico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    data_emissao DATE NOT NULL,
    data_conclusao DATE,
    status ENUM('Aberta', 'Em andamento', 'Concluída', 'Cancelada') DEFAULT 'Aberta',
    id_veiculo INT,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

-- Tabela Servico
DROP TABLE IF EXISTS Servico;
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela Funcionario
DROP TABLE IF EXISTS Funcionario;
CREATE TABLE Funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    especialidade VARCHAR(100)
);

-- Tabela OS_Servico
DROP TABLE IF EXISTS OS_Servico;
CREATE TABLE OS_Servico (
    id_os INT,
    id_servico INT,
    id_funcionario INT,
    quantidade INT DEFAULT 1,
    tempo_estimado DECIMAL(5,2),
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES OrdemServico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario)
);

-- Tabela Peca
DROP TABLE IF EXISTS Peca;
CREATE TABLE Peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0
);

-- Tabela OS_Peca
DROP TABLE IF EXISTS OS_Peca;
CREATE TABLE OS_Peca (
    id_os INT,
    id_peca INT,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os) REFERENCES OrdemServico(id_os),
    FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);

-- Tabela Pagamento
DROP TABLE IF EXISTS Pagamento;
CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_os INT,
    forma_pagamento ENUM('Dinheiro', 'Cartão Crédito', 'Cartão Débito', 'Pix', 'Boleto'),
    valor_pago DECIMAL(10,2),
    data_pagamento DATE,
    FOREIGN KEY (id_os) REFERENCES OrdemServico(id_os)
);

-- Inserção de Clientes
INSERT INTO Cliente (nome, telefone, email, cpf_cnpj, tipo_cliente) VALUES
('João Silva', '11998887777', 'joao@gmail.com', '123.456.789-00', 'PF'),
('Oficina Premium LTDA', '1133224455', 'contato@premium.com.br', '12.345.678/0001-90', 'PJ'),
('Maria Oliveira', '11991112222', 'maria@gmail.com', '987.654.321-00', 'PF');

-- Inserção de Veículos
INSERT INTO Veiculo (modelo, marca, placa, ano, id_cliente) VALUES
('Gol', 'Volkswagen', 'ABC1D23', 2015, 1),
('Civic', 'Honda', 'XYZ9W87', 2020, 3),
('Sprinter', 'Mercedes-Benz', 'FGA2B34', 2019, 2);

-- Inserção de Funcionários
INSERT INTO Funcionario (nome, cargo, especialidade) VALUES
('Carlos Mecânico', 'Mecânico', 'Motor'),
('Ana Souza', 'Eletricista', 'Elétrica Automotiva'),
('Rafael Lima', 'Supervisor', 'Gerência de OS');

-- Inserção de Serviços
INSERT INTO Servico (descricao, preco) VALUES
('Troca de óleo', 120.00),
('Revisão elétrica', 250.00),
('Alinhamento e balanceamento', 180.00),
('Reparo no motor', 900.00);

-- Inserção de Peças
INSERT INTO Peca (nome, preco_unitario, estoque) VALUES
('Filtro de óleo', 35.00, 50),
('Vela de ignição', 18.00, 100),
('Bateria 60Ah', 320.00, 20),
('Pastilha de freio', 95.00, 30);

-- Inserção de Ordens de Serviço
INSERT INTO OrdemServico (data_emissao, data_conclusao, status, id_veiculo) VALUES
('2025-04-01', '2025-04-02', 'Concluída', 1),
('2025-04-05', NULL, 'Em andamento', 2),
('2025-04-07', NULL, 'Aberta', 3);

-- 1. Inserção de Serviços (garante que os IDs 1 a 4 existam)
INSERT INTO Servico (descricao, preco) VALUES
('Troca de óleo', 120.00),
('Revisão elétrica', 250.00),
('Alinhamento e balanceamento', 180.00),
('Reparo no motor', 900.00);


-- Inserção de OS_Peca
INSERT INTO OS_Peca (id_os, id_peca, quantidade) VALUES
(1, 1, 1), -- Filtro de óleo
(2, 3, 1), -- Bateria
(3, 4, 2); -- Pastilhas de freio

-- Inserção de Pagamentos
INSERT INTO Pagamento (id_os, forma_pagamento, valor_pago, data_pagamento) VALUES
(1, 'Cartão Crédito', 300.00, '2025-04-02');

-- 2. Inserção em OS_Servico 
INSERT INTO OS_Servico (id_os, id_servico, id_funcionario, quantidade, tempo_estimado) VALUES
(1, 1, 1, 1, 1.0), -- Troca de óleo feita por Carlos
(1, 3, 1, 1, 1.5), -- Alinhamento feito por Carlos
(2, 2, 2, 1, 2.0), -- Revisão elétrica feita por Ana
(3, 4, 1, 1, 3.5); -- Reparo no motor feito por Carlos

SELECT 
    os.id_os,
    os.data_emissao,
    os.status,
    c.nome AS cliente,
    v.modelo AS veiculo
FROM OrdemServico os
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
JOIN Cliente c ON v.id_cliente = c.id_cliente
WHERE os.status IN ('Aberta', 'Em andamento')
ORDER BY os.data_emissao DESC;

SELECT 
    status,
    COUNT(*) AS total
FROM OrdemServico
GROUP BY status
HAVING COUNT(*) > 1;

SELECT 
    os.id_os,
    p.nome AS peca,
    osp.quantidade,
    p.preco_unitario,
    (osp.quantidade * p.preco_unitario) AS custo_total
FROM OS_Peca osp
JOIN Peca p ON osp.id_peca = p.id_peca
JOIN OrdemServico os ON osp.id_os = os.id_os
ORDER BY os.id_os;

SELECT 
    f.nome,
    f.especialidade,
    COUNT(os.id_os) AS total_servicos,
    SUM(oss.tempo_estimado) AS horas_estimadas
FROM OS_Servico oss
JOIN Funcionario f ON oss.id_funcionario = f.id_funcionario
JOIN OrdemServico os ON oss.id_os = os.id_os
GROUP BY f.nome, f.especialidade
ORDER BY total_servicos DESC;

SELECT 
    forma_pagamento,
    COUNT(*) AS total_pagamentos,
    SUM(valor_pago) AS total_faturado
FROM Pagamento
GROUP BY forma_pagamento
ORDER BY total_faturado DESC;

SELECT 
    os.id_os,
    SUM(s.preco * oss.quantidade) AS valor_estimado_servicos
FROM OS_Servico oss
JOIN Servico s ON oss.id_servico = s.id_servico
JOIN OrdemServico os ON oss.id_os = os.id_os
GROUP BY os.id_os;

SELECT 
    c.nome AS cliente_pj,
    v.modelo,
    v.placa
FROM Cliente c
JOIN Veiculo v ON c.id_cliente = v.id_cliente
WHERE c.tipo_cliente = 'PJ';


