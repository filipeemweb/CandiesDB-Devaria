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


-- GROUP BY --
/* Qual é a quantidade de clientes por cidade? */
SELECT 
    COUNT(*) AS Qtd_Clientes,
    Cidade
FROM
    Cliente
GROUP BY
    Cidade

/* Qual é a quantidade de formas de pagamento por tipo? */
SELECT 
    COUNT(*) AS Qtd_Formas_Pag,
    Tipo
FROM
    Forma_Pagamento
GROUP BY
    Tipo

/* Qual é o valor de venda da Candies por cada mês do ano? */
SELECT
    SUM(Valor) AS Vendas_Mensais,
    MONTH([Data]) AS Mes
FROM
    Pedido_Venda 
GROUP BY
    MONTH([Data])


-- CASE WHEN --
/* Trazer os nomes dos clientes classificando se é fora ou dentro do estado de SP. */
SELECT
    CASE
        WHEN Estado = 'SP' THEN 'Dentro de São Paulo'
        ELSE 'Fora de São Paulo'
    END AS Localidade,
    Nome,
    Estado
FROM
    Cliente

/* Trazer as formas de pagamento classidicando-as em cartão, refeição ou outro tipo de pagamento. */
SELECT
    Nome,
    CASE
        WHEN Tipo LIKE '%Cartão%' THEN 'Cartão'
        WHEN Tipo LIKE '%Refeição%' THEN 'Refeição'
        ELSE 'Outros'
    END AS Tipo_Pagamento
FROM
    Forma_Pagamento


-- INNER JOIN --
/* Quais são os nomes dos clientes que possuem fidelidade e quantos pontos eles possuem? */
SELECT
    C.Nome,
    F.Pontos
FROM
    Cliente AS C
    INNER JOIN Fidelidade AS F ON C.Codigo = F.Codigo_Cliente

/* Qual a quantidade de venda de cada produto vendido com o nome? */
SELECT
    P.Nome,
    SUM(IPV.Quantidade) AS Quantidade
FROM
    Item_Pedido_Venda AS IPV
    INNER JOIN Produto AS P ON P.Codigo = IPV.Codigo_Produto
GROUP BY
    P.Nome

/* Qual a quantidade de venda de cada produto vendido com o nome e marca? */
SELECT
    P.Nome AS [Nome Produto],
    M.Nome AS [Nome Marca],
    SUM(I.Quantidade) AS Quantidade
FROM
    Item_Pedido_Venda AS I
    INNER JOIN Produto AS P ON P.Codigo = I.Codigo_Produto
    INNER JOIN Marca AS M On M.Codigo = P.Codigo_Marca
GROUP BY
    P.Nome, M.Nome
ORDER BY
    SUM(I.Quantidade) DESC


-- LEFT JOIN --
/* Quais são os nomes de todos os clientes e quantos pontos eles possuem? */
SELECT 
    C.Nome,
    CASE
        WHEN F.Pontos IS NULL THEN 0
        ELSE F.Pontos
    END AS Pontos_Cliente
FROM
    Cliente AS C
    LEFT JOIN Fidelidade AS F ON C.Codigo = F.Codigo_Cliente
ORDER BY
    F.Pontos DESC

/* Quais são os nomes dos distribuidores e tragam o valor de compra que a Candies realizou, inclusive os que não possuem compras? */
SELECT
   D.Nome_Fantasia,
    CASE
        WHEN SUM(PC.Valor) IS NULL THEN 0
        ELSE SUM(PC.Valor)
    END AS Valor_Comprado
FROM
    Distribuidor AS D
    LEFT JOIN Pedido_Compra AS PC ON D.Codigo = PC.Codigo_Distribuidor
GROUP BY
    D.Nome_Fantasia
 

-- LEFT OUTER JOIN --
/* Quais são os nomes dos clientes que nao tem fidelidade? */
SELECT
    C.Nome,
    C.Telefone
FROM
    Cliente AS C
    LEFT JOIN Fidelidade AS F ON C.Codigo = F.Codigo_Cliente
WHERE
    F.Pontos IS NULL

/* Quais produtos que nunca foram vendidos? */
SELECT
    P.Nome
FROM
    Produto AS P
    LEFT JOIN Item_Pedido_Venda AS I ON P.Codigo = I.Codigo_Produto
WHERE 
    I.Quantidade IS NULL


--COMMIT
--ROLLBACK