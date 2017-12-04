/*
Sample Data
-----------
                      game
--------------------------------------------------------------
id    mdate         stadium                     team1   team2
1001  8 June 2012   National Stadium, Warsaw    POL     GRE
1002  8 June 2012   Stadion Meijski (Wroclaw)   RUS     CZE
1003  12 June 2012  Stadion Meijski (Wroclaw)   GRE     CZE
1004  12 June 2012  National Stadium, Warsaw    POL     RUS

                  goal
-----------------------------------------------
matchid   teamid    player               gtime
1001      POL       Robert Lewandowski   17
1001      GRE       Dimitris Salpingidis 51
1002      RUS       Alan Dzagoev         15
1002      RUS       Roman Pavlyuchenko   82

                 eteam
----------------------------------------
id      teamname        coach
POL     Poland          Franciszek Smuda
RUS     Russia          Dick Advocaat
CZE     Czech Republic  Michal Bilek
GRE     Greece          Fernando Santos
*/

-- 1. Show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'Ger'
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- 2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match. Notice in the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table. Show id, stadium, team1, team2 for just game 1012.
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- 3. You can combine the two steps into a single query with a JOIN. `SELECT * FROM game JOIN goal ON (id=matchid)` The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the id from goal must match matchid from game. (If we wanted to be more clear/specific we could say ON (game.id=goal.matchid)). Show the player, teamid, stadium, and mdate for every German goal.
SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM goal
JOIN game
ON (goal.matchid = game.id);
WHERE goal.teamid = 'GER';

-- 4. Use the same JOIN. Show the team1, team2 and player for every goal scored by a player called Mario: player LIKE 'Mario%'
SELECT game.team1, game.team2, goal.player
FROM game
JOIN goal
ON (game.id = goal.matchid)
WHERE goal.player LIKE 'Mario%';

-- 5. The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime <= 10.
SELECT goal.player, goal.teamid, eteam.coach, goal.gtime
FROM goal JOIN eteam
ON (goal.teamid = eteam.id)
WHERE goal.gtime <= 10;

-- 6. To JOIN game with eteam you could use either game JOIN eteam ON (team1 = eteam.id) or game JOIN eteam on (team2 = eteam.id). Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT game.mdate, eteam.teamname
FROM game JOIN eteam
ON (game.team1 = eteam.id)
WHERE eteam.coach = 'Fernando Santos';

-- 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'.
SELECT goal.player
FROM goal JOIN game
ON (game.id = goal.matchid)
WHERE game.stadium = 'National Stadium, Warsaw';

-- 8. Show name of all the players who scored a goal against Germany.
SELECT DISTINCT goal.player
FROM goal JOIN game
ON (game.id = goal.matchid)
WHERE (game.team1 = 'GER' OR game.team2 = 'GER') AND goal.teamid !='GER';

-- 9. Show teamname and the total numbers of goals scored. Use COUNT and GROUP BY.
SELECT eteam.teamname, COUNT(*) as goals
FROM eteam JOIN goal
ON (eteam.id = goal.teamid)
GROUP BY eteam.teamname;

-- 10. Show the stadium and the number of goals scored in each stadium.
SELECT game.stadium, COUNT(*) as goals
FROM game JOIN goal
ON (game.id = goal.matchid)
GROUP BY game.stadium;

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT goal.matchid, game.mdate, COUNT(*) as goals
FROM goal JOIN game
ON (goal.matchid = game.id)
WHERE (game.team1 = 'POL' OR game.team2 = 'POL')
GROUP BY goal.matchid, game.mdate
ORDER BY goal.matchid;

-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'.
SELECT goal.matchid, game.mdate, COUNT(*) as goals
FROM goal JOIN game
ON (goal.matchid = game.id)
WHERE goal.teamid = 'GER'
GROUP BY goal.matchid, game.mdate
ORDER BY goal.matchid;

-- 13. List every match with the goals scored by each team as shown. Use 'CASE WHEN'. Sort result by mdate, matchid, id, team1 and team2.
/*
sample answer:
mdate         team1   score1    team2   score2
1 July 2012   ESP     4         ITA     0
10 June 2012  ESP     1         ITA     1
10 June 2012  IRL     1         CRO     3
...
*/
SELECT game.mdate, game.team1,
SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) as score1,
game.team2,
SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) as score2
FROM game LEFT JOIN goal ON (game.id = goal.matchid)
GROUP BY game.mdate, game.team1, game.team2
ORDER BY game.mdate, game.team1, game.team2;
