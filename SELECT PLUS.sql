-- ## EXCERCÍCIOS ## --

BEGIN TRANSACTION

-- MIN e MAX --
/* Qual é a compra que a Candies gastou menos? */
SELECT
    MIN(Valor) AS Menor_Compra
FROM
    Pedido_Compra

/* Qual é a venda mais alta da Candies? */
SELECT 
    MAX(Valor) AS Maior_Venda
FROM
    Pedido_Venda

/* Qual é o plano de fidelidade mais antigo da Candies? */
SELECT
    MIN(Data_Adesao) AS Primeira_Fidelidade
FROM
    Fidelidade

/* Qual a maior venda realizada no mês de fevereiro? */
SELECT 
    MAX(Valor) AS Maior_Venda_Fev
FROM
    Pedido_Venda
WHERE
    MONTH(Data) = 02 --([Data] >= '2021:02:01' AND [Data] <= '2021:02:28')


-- COUNT --
/* Quantos clientes a Candies possui ao total? */
SELECT
    COUNT(*) AS Clientes_Totais
FROM
    Cliente
    
/* Quantas compras com valores maiores que R$1000,00 foram realizadas? */
SELECT
    COUNT(*) AS Compras_Altas
FROM
    Pedido_Compra
WHERE
    Valor > 1000

/* Quantos clientes são de São Paulo? */
SELECT
    COUNT(*) AS Clientes_Paulistas
FROM
    Cliente
WHERE
    Estado = 'SP'


-- SUM --
/* Quantas unidades de doces a Candies comprou? */
SELECT
    SUM(Quantidade) AS Total_Doces_Comprados
FROM
    Item_Pedido_Compra

/* Qual o valor total de impostos de vendas da Candies? */
SELECT
    SUM(Valor_Imposto) AS Total_Impostos_Venda
FROM
    Pedido_Venda

/* Quantos pontos de fidelidade já foram distribuidos? */
SELECT
    SUM(Pontos) AS Pontos_Distribuidos
FROM
    Fidelidade


-- AVG(Average) --
/* Qual é a média de gastos de compras da Candies? */
SELECT
    AVG(Valor) AS Media_Gastos
FROM
    Pedido_Compra

/* Qual é o ticket(valor gasto) médio dos clientes da Candies? */
SELECT
    AVG(Valor) AS Media_Ticket
FROM
    Pedido_Venda

/* Qual a quantidade média de itens vendidos na Candies?  */
SELECT
    AVG(Quantidade) AS Media_Itens_Vendidos
FROM
    Item_Pedido_Venda


-- OPERADORES ARITMÉTICOS(+, -, /, *)
/* Qual o valor das vendas sem o valor dos impostos? */
SELECT
    Valor - Valor_Imposto AS Vendas_Sem_Imposto
FROM
    Pedido_Venda

/* Qual o valor unitário de cada produto vendido considerando o valor do imposto? */
SELECT
    Valor_Unitario + Valor_Imposto AS Itens_Com_Imposto
FROM
    Item_Pedido_Venda

/* Qual o valor de cada item vendido considerando o valor do imposto? */
SELECT
    Valor + Valor_Imposto AS Venda_Com_Imposto
FROM
    Pedido_Venda

/* Qual a quantidade de pontos de fidelidade se todos os clientes comprassem a metade? E se comprassem o dobro? */
SELECT
    Pontos / 2 AS Pontos_Metade,
    Pontos AS Pontos_Atuais,
    Pontos * 2 AS Pontos_Dobro
FROM
    Fidelidade

    
--COMMIT
--ROLLBACK