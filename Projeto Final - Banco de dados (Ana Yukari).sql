create database ProjetoBD

create table Funcionarios( 
ID SERIAL primary key,
Nome VARCHAR (150) not null,
Email VARCHAR (100) unique not null check(Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$' )
);

alter table Funcionarios rename to Funcionario; -- mudei porq escrevi errado o nome da tabela

create table Quiz( 
ID SERIAL primary key,
DataInicio DATE not null,
DataTermino DATE not null,
Tema VARCHAR(100) not null
);

alter table Quiz 
alter column DataInicio set default current_date ; -- 'setei' a data de incio para o padrão 'now'

create table Pergunta( 
ID SERIAL primary key,
Enunciado VARCHAR not null,
Quiz_ID INT,
foreign key (Quiz_ID) references Quiz(ID),
ALt_Correta VARCHAR not null,
ALt_1 VARCHAR not null,
ALt_2 VARCHAR not null,
ALt_3 VARCHAR not null,
ALt_4 VARCHAR not null
);

create table Resultado( 
ID SERIAL primary key,
Quiz_ID INT,
foreign key (Quiz_ID) references Quiz(ID),
Funcionario_ID INT,
foreign key (Funcionario_ID) references Funcionario(ID),
Pergunta_ID INT,	
foreign key (Pergunta_ID) references Pergunta(ID),
DataHora DATE not null default CURRENT_DATE,
Resposta INT not null check (Resposta = 1 or Resposta = 0)
);

alter table resultado rename column Resposta to Pontuacao;


-- Completando tabela Funcionario:

insert into funcionario (nome , email) values 
('Felipe Lacerda' , 'felipe@gmail.com');
insert into funcionario (nome , email) values
('Zepa' , 'zepa@gmail.com');
insert into funcionario (nome , email) values
('Ana Yukari' , 'anayukari@gmail.com');
insert into funcionario (nome , email) values
('Maria Eduarda' , 'madu@gmail.com');
insert into funcionario (nome , email) values
('Nicolle' , 'nicolle@gmail.com');
insert into funcionario (nome , email) values
('Bianco' , 'bianco@gmail.com');
insert into funcionario (nome , email) values
('Kaiky' , 'kaiky@gmail.com');


-- Completando tabela Quiz:

insert into Quiz (DataTermino , tema) values
('2024-03-30' , 'Natureza');
insert into Quiz (DataTermino , tema) values
('2024-03-30' , 'Nova Friburgo');
insert into Quiz (DataTermino , tema) values
('2024-03-30' , 'Dia da Mulher');
insert into Quiz (DataTermino , tema) values
('2024-03-30' , 'Matemática');


-- Completando tabela Pergunta:

insert into pergunta (enunciado , quiz_id , alt_correta , alt_1 , alt_2 , alt_3 , alt_4) values
('Qual é a cor da folha?' , 3 , 'Verde' , 'Roxo' , 'Amarelo' , 'Laranja' , 'Azul' );
insert into pergunta (enunciado , quiz_id , alt_correta , alt_1 , alt_2 , alt_3 , alt_4) values
('O que as plantas produzem?' , 3 , 'Oxigênio' , 'Gás carbônico' , 'Nitrogênio' , 'Hidrogenio' , 'Amônia' );
insert into pergunta (enunciado , quiz_id , alt_correta , alt_1 , alt_2 , alt_3 , alt_4) values
('"quantos anos Nova Friburgo tem?' , 4 , '204' , '205' , '203' , '202' , '201' );
insert into pergunta (enunciado , quiz_id , alt_correta , alt_1 , alt_2 , alt_3 , alt_4) values
('Qual é o dia da mulher?' , 5 , '08 de Março' , '15 de Maio' , '12 de Abril' , '07 de Agosto' , '09 de junho' );
insert into pergunta (enunciado , quiz_id , alt_correta , alt_1 , alt_2 , alt_3 , alt_4) values
('6 x 8' , 6 , '48' , '52' , '38' , '42' , '46' );
insert into pergunta (enunciado , quiz_id , alt_correta , alt_1 , alt_2 , alt_3 , alt_4) values
('15 dividido por 2' , 6 , '7.5' , '8.5' , '6.5' , '8' , '7' );
insert into pergunta (enunciado , quiz_id , alt_correta , alt_1 , alt_2 , alt_3 , alt_4) values
('30 + 43' , 6 , '73' , '63' , '83' , '93' , '66' );



-- Corrigindo tabela pergunta (esquci os pontos de interrogação)
update pergunta set enunciado = '6 x 8?' where id = 7;
update pergunta set enunciado = '30 + 43?' where id = 9;

-- Completando a tablea resultado
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(3,2,1,0);

update resultado set Pergunta_ID = 3 where id = 2; -- precisei fazer essa alteração para excluir uma linha repetida
delete from pergunta where id = 2; -- exclui uma linha repetida

insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(5,6,4,0);
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(3,4,3,1);
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(6,8,2,0);
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(6,8,6,1);
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(4,5,3,0);
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(4,5,5,1);
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(3,3,4,1);
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(6,9,5,0);
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(6,7,3,1);
insert into resultado (Quiz_ID , Pergunta_ID , Funcionario_ID , Pontuacao)values 
(4,5,4,1),
(5,6,7,1),
(3,4,6,1),
(4,5,4,1),
(6,8,7,1),
(3,3,5,1);

delete from resultado where id = 15; -- exclui uma linha repetida

-- quero ver quem tem a maior pontuação geral

select Funcionario.nome as Nome , SUM(resultado.pontuacao) as pontuacao_total from Funcionario
inner join resultado on funcionario.id = resultado.funcionario_id
group by funcionario.nome
order by pontuacao_total desc;

-- quero ver quem tem a maior pontuação em certo quiz

SELECT Funcionario.nome AS Nome, quiz.tema, SUM(resultado.pontuacao) AS pontuacao_total 
FROM Funcionario
INNER JOIN resultado ON Funcionario.id = resultado.funcionario_id
INNER JOIN quiz ON resultado.quiz_id = quiz.id
WHERE quiz.id = 4
GROUP BY Funcionario.nome, quiz.tema
ORDER BY pontuacao_total DESC;



-- quero ver a pontuação de algum funcionário

select funcionario.nome as Nome, sum(resultado.pontuacao) as pontuacao_total from funcionario
inner join resultado on funcionario.id = resultado.funcionario_id where funcionario.id = 2
group by funcionario.nome;

-- 

select * from Funcionario;
select * from Quiz;
select * from Pergunta;
select * from Resultado;
