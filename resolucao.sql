@c:/cp5/cp5_script.sql

SELECT * FROM cp_5_colaboradores; 

SELECT * FROM cp_5_projetos;

SELECT * FROM cp_5_tarefas; 

/* Questão 1 (DML) - Adicione um novo colaborador chamado 'Fernando Rocha', 
    com ID 106, cargo 'Especialista de QA' e salário de 6800.00. */

INSERT INTO cp_5_colaboradores VALUES (106, 'Fernando Rocha', 
    'Especialista de QA', 6800.00);
    
/* Questão 2 (DML) - Aumente o salário de todos os colaboradores com cargo de 
    'Desenvolvedora Pleno' em 10% */

UPDATE cp_5_colaboradores
    SET salario = salario * 1.1
        WHERE cargo = 'Desenvolvedora Pleno';

/* Questão 3 (DML) - O DBA Sênior (ID 105) foi alocado para a tarefa de 
     'Documentação Final' (ID 308). Atualize o ID_COLABORADOR desta tarefa. */

UPDATE cp_5_tarefas
    SET id_colaborador = 105
        WHERE descricao = 'Documentação Final';
        

/* Questão 4 (DQL) - Elabore uma consulta SQL para obter uma visão completa 
    das tarefas, incluindo o nome do projeto, seu status, a prioridade da 
    tarefa, o nome do colaborador atribuído, a descrição da tarefa e o salário 
    do colaborador. 
    As informações devem ser combinadas das tabelas CP_5_PROJETOS, CP_5_TAREFAS 
    e CP_5_COLABORADORES, garantindo que apenas as tarefas atribuídas a um
    colaborador e a um projeto existente sejam exibidas, atributos desejados 
    no comando: NOME_PROJETO, STATUS, PRIORIDADE, NOME DO COLABORADOR,
    DESCRICAO DA TAREFA, SALARIO */

SELECT 
    cp_5_projetos.nome_projeto AS "NOME PROJETO",
    cp_5_projetos.status AS "STATUS",
    cp_5_tarefas.prioridade AS "PRIORIDADE",
    cp_5_colaboradores.nome AS "NOME COLABORADOR",
    cp_5_tarefas.descricao AS "DESCRICAO TAREFA",
    cp_5_colaboradores.salario AS "SALARIO COLABORADOR"
FROM cp_5_tarefas
JOIN cp_5_projetos ON cp_5_tarefas.id_projeto = cp_5_projetos.id_projeto
JOIN cp_5_colaboradores ON cp_5_tarefas.id_colaborador = cp_5_colaboradores.id_colaborador;

/* Questão 5 (DQL) - Liste o nome do colaborador e o nome do projeto de todas 
    as tarefas com Prioridade 'Alta', utilizando INNER JOIN. */

SELECT 
    cp_5_colaboradores.nome AS "NOME COLABORADOR",
    cp_5_projetos.nome_projeto AS "NOME PROJETO",
    cp_5_tarefas.prioridade AS "PRIORIDADE",
    cp_5_tarefas.descricao AS "DESCRICAO TAREFA"
FROM cp_5_tarefas
INNER JOIN cp_5_colaboradores ON cp_5_tarefas.id_colaborador = cp_5_colaboradores.id_colaborador
INNER JOIN cp_5_projetos ON cp_5_tarefas.id_projeto = cp_5_projetos.id_projeto
WHERE cp_5_tarefas.prioridade = 'Alta';

/* Questão 6 (DQL) - Calcule o salário médio (AVG) e o salário máximo (MAX) de 
    todos os colaboradores. */
    
SELECT 
    AVG(salario) AS "Salario Médio",
    MAX(salario) AS "Salario Máximo"
FROM cp_5_colaboradores;
    
/* Questão 7 (DQL) - Conte quantas tarefas estão atribuídas a cada projeto, 
    listando o nome do projeto e o total de tarefas. Inclua apenas projetos 
    que possuam mais de 2 tarefas (COUNT > 2). */
    
SELECT 
    cp_5_projetos.nome_projeto AS "NOME PROJETO",
    COUNT(cp_5_tarefas.id_tarefa) AS "TOTAL TAREFAS"
FROM cp_5_projetos
INNER JOIN 
    cp_5_tarefas ON cp_5_projetos.id_projeto = cp_5_tarefas.id_projeto
GROUP BY cp_5_projetos.nome_projeto
HAVING 
    COUNT(cp_5_tarefas.id_tarefa) > 2;
    
/* Questão 8 (DQL) - Liste o nome de todos os projetos que estão com o STATUS 
    'Em Andamento' e que iniciaram antes de 1º de Abril de 2024. */
    
SELECT nome_projeto AS "nome projeto", data_inicio AS "data inicio"
FROM cp_5_projetos
WHERE 
status = 'Em Andamento' AND data_inicio < TO_DATE('01/04/2024', 'DD/MM/YYYY');


/* Questão 9 (DQL) - Encontre o nome dos colaboradores que NÃO possuem 
    tarefas atribuídas na tabela CP_5_TAREFAS, utilizando um LEFT JOIN 
    ou RIGHT JOIN. */

SELECT 
    cp_5_colaboradores.nome AS "nome colaborador",
    cp_5_colaboradores.id_colaborador AS "id colaborador"
FROM cp_5_colaboradores
LEFT JOIN 
    cp_5_tarefas ON cp_5_colaboradores.id_colaborador = cp_5_tarefas.id_colaborador
WHERE cp_5_tarefas.id_tarefa IS NULL;


/* Questão 10 (DQL) - Liste a descrição das 3 tarefas com a data de entrega 
    mais próxima da data atual, ordenadas de forma ascendente. */
    
SELECT descricao AS "DESCRICAO DA TAREFA", data_entrega AS "DATA ENTREGA"
FROM cp_5_tarefas
WHERE cp_5_tarefas.data_entrega < SYSDATE
ORDER BY cp_5_tarefas.data_entrega DESC
FETCH FIRST 3 ROWS ONLY;
