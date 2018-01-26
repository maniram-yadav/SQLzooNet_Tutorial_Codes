The JOIN operation
FootballERD.png

game
id	mdate	stadium	team1	team2
1001	8 June 2012	National Stadium, Warsaw	POL	GRE
1002	8 June 2012	Stadion Miejski (Wroclaw)	RUS	CZE
1003	12 June 2012	Stadion Miejski (Wroclaw)	GRE	CZE
1004	12 June 2012	National Stadium, Warsaw	POL	RUS
...

goal
matchid	teamid	player	gtime
1001	POL	Robert Lewandowski	17
1001	GRE	Dimitris Salpingidis	51
1002	RUS	Alan Dzagoev	15
1002	RUS	Roman Pavlyuchenko	82
...

eteam
id	teamname	coach
POL	Poland	Franciszek Smuda
RUS	Russia	Dick Advocaat
CZE	Czech Republic	Michal Bilek
GRE	Greece	Fernando Santos











<--

1.
The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
-->

SELECT matchid, player FROM goal 
  WHERE teamid='GER'






<--
2.
From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.

Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.

Show id, stadium, team1, team2 for just game 1012
-->

SELECT id,stadium,team1,team2
  FROM game  where id=1012




<--

3.
You can combine the two steps into a single query with a JOIN.

SELECT *
  FROM game JOIN goal ON (id=matchid)
The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the id from goal must match matchid from game. (If we wanted to be more clear/specific we could say 
ON (game.id=goal.matchid)

The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
Modify it to show the player, teamid, stadium and mdate for every German goal.
-->

SELECT goal.player,goal.teamid,game.stadium,game.mdate
  FROM game JOIN goal ON (game.id=goal.matchid) and goal.teamid='GER'






<--
4.
Use the same JOIN as in the previous question.

Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
-->


SELECT game.team1,game.team2,goal.player
  FROM game JOIN goal ON (game.id=goal.matchid) and 
  goal.player like 'Mario%'



<--
5.
The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
-->

SELECT g.player, g.teamid, e.coach, g.gtime
  FROM goal as g JOIN  eteam as e ON (e.id=g.teamid)
 WHERE gtime<=10







<--
6.
To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
-->

select g.mdate,e.teamname from game as g JOIN eteam as e ON (g.team1=e.id) where e.coach='Fernando Santos'







<--
7.
List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
-->

select g.player from goal as g JOIN game as ga ON (g.matchid=ga.id) where ga.stadium='National Stadium, Warsaw'













<--
8.
The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany.

-->

SELECT distinct go.player
  FROM game as g JOIN goal as go ON go.matchid = g.id 
    
   WHERE  (g.team1='GER' or g.team2='GER') and 
    go.teamid!='GER'










<--
9.
Show teamname and the total number of goals scored.
COUNT and GROUP BY
You should COUNT(*) in the SELECT line and GROUP BY teamname
-->

SELECT e.teamname,count(*)
  FROM eteam as e JOIN goal as g ON e.id=g.teamid
  group by e.teamname








<--
10.
Show the stadium and the number of goals scored in each stadium.
-->

select g.stadium,count(*) from game as g JOIN goal as go ON (g.id=go.matchid) group by g.stadium










<--
11.
For every match involving 'POL', show the matchid, date and the number of goals scored.
-->

SELECT go.matchid,g.mdate,count(go.teamid)
  FROM game as g JOIN goal as go ON go.matchid = g.id 
 WHERE (g.team1 = 'POL' OR g.team2 = 'POL') group by go.matchid,g.mdate









<--
12.
For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
-->


SELECT go.matchid,g.mdate,count(*)
  FROM game as g JOIN goal as go ON go.matchid = g.id 
 WHERE go.teamid='GER' group by go.matchid,g.mdate







<--
13.
List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA	0
10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
-->



SELECT g.mdate,
g.team1,SUM(CASE WHEN go.teamid=g.team1 THEN 1 ELSE 0 END) as score1,
g.team2,SUM(CASE WHEN go.teamid=g.team2 THEN 1 ELSE 0 END) as  score2
  FROM game as g LEFT JOIN goal as go ON go.matchid = g.id
  group by g.mdate,g.team1,g.team2


