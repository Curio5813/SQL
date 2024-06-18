--- URI Online Judge SQL
--- Copyright URI Online Judge
--- www.urionlinejudge.com.br
--- Problem 2988

CREATE TABLE teams (
    id integer PRIMARY KEY,
    name varchar(50)
);

GRANT SELECT ON teams TO sql_user;

CREATE TABLE matches  (
    id integer PRIMARY KEY,
    team_1 integer,
    team_2 integer,
    team_1_goals integer,
    team_2_goals integer,
    FOREIGN KEY (team_1) REFERENCES teams(id),
    FOREIGN KEY (team_2) REFERENCES teams(id)
);

GRANT SELECT ON matches TO sql_user;insert into teams
    (id, name)
values
    (1,'CEARA'),
    (2,'FORTALEZA'),
    (3,'GUARANY DE SOBRAL'),
    (4,'FLORESTA');

insert into  matches
    (id, team_1, team_2, team_1_goals, team_2_goals)
values
    (1,4,1,0,4),
    (2,3,2,0,1),
    (3,1,3,3,0),
    (4,3,4,0,1),
    (5,1,2,0,0),
    (6,2,4,2,1);

SELECT
  name,
  count(name) as matches,
  sum(CAST(Vitorias AS int)) as victories,
  sum(CAST(Derrotas AS int)) as defeats,
  sum(CAST(Empate AS int)) as draws,
  (sum(CAST(Vitorias AS int)) * 3) + (sum(CAST(Empate AS int)) * 1) as score
FROM
  (
    SELECT
      teams.name,
      matches.team_1 as ID,
      (matches.team_1_goals > matches.team_2_goals) as Vitorias,
      (matches.team_1_goals < matches.team_2_goals) as Derrotas,
      (matches.team_1_goals = matches.team_2_goals) as Empate
    FROM
      teams
      INNER JOIN matches ON matches.team_1 = teams.id
    UNION ALL
    SELECT
      teams.name,
      matches.team_2 as ID,
      (matches.team_2_goals > matches.team_1_goals) as Vitorias,
      (matches.team_2_goals < matches.team_1_goals) as Derrotas,
      (matches.team_2_goals = matches.team_1_goals) as Empate
    FROM
      teams
      INNER JOIN matches ON matches.team_2 = teams.id
  ) as tabela
GROUP BY
  name
ORDER BY
    score DESC;
