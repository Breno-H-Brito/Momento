use momento;
-- 1.1 Inserir os meus dados no sistema
INSERT INTO funcionarios
(primeiro_nome, sobrenome, email, senha, telefone, data_contratacao, cargo_id, salario, gerente_id, departamento_id)
VALUES
('Breno', 'Brito', 'brenobritodev@gmail.com', '123456789', '11917442943', CURDATE(), 22, 5000.00, 103, 6);
 
-- 1.2 Ver quantos funcionarios tna empresa

SELECT COUNT(*) AS total_funcionarios
FROM funcionarios;
 
-- 1.3 Mostra quantos trabalham por numero
SELECT COUNT(*) AS total_tecnologia
FROM funcionarios
WHERE departamento_id = 6;
 
-- mostra quantos tem com nomes
SELECT f.primeiro_nome, f.sobrenome, d.departamento_nome
FROM funcionarios f
JOIN departamentos d
ON f.departamento_id = d.departamento_id
WHERE d.departamento_nome = 'Tecnologia';
 
-- 1.4 todos departamentos da empresa
SELECT * FROM departamentos;
 
SELECT COUNT(*) AS total_departamentos
FROM departamentos;
 
-- 1.5 total de escritórios
SELECT COUNT(*) AS total_escritorios
FROM escritorios;
 
-- países onde existem escritórios
SELECT DISTINCT p.pais_nome
FROM escritorios e
JOIN paises p
ON e.pais_id = p.pais_id;
 
 -- Nível 2: Análise Financeira Básica

-- 2.1 Quantos funcionários trabalham no Departamento de Vendas?
	SELECT COUNT(*) AS 'Departamento de Vendas'
    FROM funcionarios f
    JOIN departamentos d
    ON f.departamento_id = d.departamento_id
    WHERE d.departamento_nome = 'Vendas';



-- 2.2 Qual é o custo total com salários do Departamento de Vendas?
SELECT SUM(f.salario) AS custo_total
FROM funcionarios f 
JOIN departamentos d
ON f.departamento_id = d.departamento_id 
WHERE departamento_nome = 'Vendas';

-- 2.3 Qual é a média salarial da empresa, excluindo os cargos de CEO, CMO e CFO?
SELECT AVG(f.salario) AS media_salarial -- AVG() ->  calcula média
FROM funcionarios f
JOIN cargos c 
  ON f.cargo_id = c.cargo_id
WHERE c.cargo_nome NOT IN ('CEO', 'CMO', 'CFO'); -- NOT IN -> exclui valores


-- 2.4 Qual é a média salarial do Departamento de Tecnologia?
SELECT AVG(f.salario) AS media_tecnologia
FROM funcionarios
WHERE departamento_nome = 'Tecnologia';




-- 2.5 Qual departamento possui a maior média salarial?
SELECT departamento, AVG(salario) AS media_salarial
FROM dados_funcionarios
GROUP BY departamento
ORDER BY media_salarial DESC
LIMIT 1;
-- 2.6 Qual departamento possui o menor número de funcionários?
SELECT departamento, COUNT(*) AS total_funcionarios
FROM dados_funcionarios
GROUP BY departamento
ORDER BY total_funcionarios ASC
LIMIT 1;

-- Nível 3: Recursos Humanos
-- O RH está fazendo uma análise demográfica da empresa.

-- 3.1 Quantos funcionários da empresa Momento possuem cônjuges?
SELECT COUNT(*) as "Quantidade de funcionários com cônjuges"
FROM dependentes
WHERE relacionamento = 'Cônjuge';

-- 3.2 Quantos funcionários possuem filhos registrados?
SELECT COUNT(*) as "Quantidade de funcionários com filhos"
FROM dependentes
WHERE relacionamento = 'Filha(o)';

-- 3.3 Qual funcionário foi contratado há mais tempo na empresa?
SELECT primeiro_nome, sobrenome, data_contratacao
FROM funcionarios
ORDER BY data_contratacao ASC
LIMIT 1;

-- 3.4 Qual funcionário foi contratado há menos tempo na empresa?
SELECT primeiro_nome, sobrenome, data_contratacao
FROM funcionarios
ORDER BY data_contratacao DESC
LIMIT 1;

-- 3.5 Liste os 5 funcionários com mais tempo de casa, ordenados pela data de contratação.
SELECT primeiro_nome, sobrenome, data_contratacao
FROM funcionarios
ORDER BY data_contratacao ASC
LIMIT 5;

-- 3.6 Quantos funcionários foram contratados na década de 1990 (entre 1990-1999)?
SELECT COUNT(*) AS "Funcionário contratados entre 1990-1999"
FROM funcionarios
WHERE data_contratacao BETWEEN '1990-01-01' and '1999-12-31';

-- 3.7 Como a média salarial da Momento evoluiu ao longo dos anos? Agrupe por ano de contratação e calcule a média salarial.
SELECT 
    YEAR(data_contratacao) AS ano_contratacao, 
    AVG(salario) AS media_salarial
FROM funcionarios
GROUP BY YEAR(data_contratacao)
ORDER BY ano_contratacao;

-- Nível 4: Operações e Escritórios
-- 4.1 Qual é o custo total de suprimentos em cada escritório? Ordene do mais caro ao mais barato.

select * from suprimentos;

	SELECT SUM ()


-- 6.1 Um novo departamento foi criado: Inovações. Ele será alocado no escritório Adicione-o ao banco de dados.
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (14,'Inovações',1400);
 
-- 6.2 O departamento de Inovações está sem funcionários. Transfira 2 funcionários do departamento de Tecnologia para Inovações.
 
-- verificando os funcionários da tecnologia
SELECT funcionario_id, primeiro_nome, sobrenome, cargo_id, salario
FROM funcionarios
WHERE departamento_id = 6;
 
-- depois de escolher os 2 azarados vamos atualizar a tabela
UPDATE funcionarios
SET departamento_id = (SELECT departamento_id FROM departamentos WHERE departamento_nome = 'Inovações')
WHERE funcionario_id IN (105, 107) 
AND departamento_id = 6; 
SELECT f.funcionario_id, f.primeiro_nome, f.sobrenome, d.departamento_nome
FROM funcionarios f
JOIN departamentos d ON f.departamento_id = d.departamento_id
WHERE f.funcionario_id IN (105, 107);
 
-- 6.3 A empresa decidiu dar um aumento de 10% para todos os funcionários do departamento de Tecnologia. Atualize os salários.
UPDATE funcionarios SET salario = salario*1.1 WHERE departamento_id = 6;
 
-- 6.4 O funcionário "Bruce Ernst" foi promovido a "Senior Web Developer" e recebeu um aumento para $5.000. Atualize suas informações.
 
 
-- adiconar o novo cargo pq não tem
INSERT INTO cargos (cargo_nome, min_salario, max_salario)
VALUES ('Senior Web Developer', 5000.00, 15000.00);
 
UPDATE funcionarios
SET cargo_id = (SELECT cargo_id FROM cargos WHERE cargo_nome = 'Senior Web Developer'),
    salario  = 5000.00
WHERE funcionario_id = 104;
 
-- verificaçao
 
SELECT f.funcionario_id, f.primeiro_nome, f.sobrenome,
       c.cargo_nome, f.salario
FROM funcionarios f
JOIN cargos c ON f.cargo_id = c.cargo_id
WHERE f.funcionario_id = 104;
 
 
-- Todos os funcionários contratados antes de 1990 estão aposentando. 
-- Remova-os do banco de dados (CUIDADO: execute um SELECT antes para ver quantos serão afetados!).
 
-- 1- SELECT para ver quem será afetado ANTES de deletar para ter uma noção
SELECT funcionario_id, primeiro_nome, sobrenome,
       email, data_contratacao
FROM funcionarios
WHERE data_contratacao < '1990-01-01';
 
 
-- 2- remover dependentes vinculados
 
DELETE FROM dependentes
WHERE funcionario_id IN (
    SELECT funcionario_id FROM funcionarios
    WHERE data_contratacao < '1990-01-01'
    );
    --  3- remover registros do audit_log vinculados
DELETE FROM audit_log
WHERE funcionario_id IN (
    SELECT funcionario_id FROM funcionarios
    WHERE data_contratacao < '1990-01-01'
);
 
-- 4- verificar quem tem esses funcionários como gerente
 
SELECT funcionario_id, primeiro_nome, sobrenome, gerente_id
FROM funcionarios
WHERE gerente_id IN (
    SELECT funcionario_id FROM funcionarios
    WHERE data_contratacao < '1990-01-01'
    );
    -- PASSO 5- remover a referência de gerente 
UPDATE funcionarios
SET gerente_id = NULL
WHERE gerente_id IN (
    SELECT funcionario_id FROM (
        SELECT funcionario_id FROM funcionarios
        WHERE data_contratacao < '1990-01-01'
    ) AS aposentados
);
 
-- PASSO 6:
DELETE FROM funcionarios
WHERE data_contratacao < '1990-01-01';
 
 
-- Verificação de aposentadoria
SELECT funcionario_id, primeiro_nome, sobrenome, data_contratacao
FROM funcionarios
WHERE data_contratacao < '1990-01-01';
 
 
-- 6.5 Adicione um novo suprimento ao escritório 
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Headsets', 15, 2250.00, 1400);
