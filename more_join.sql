<!--
1.
List the films where the yr is 1962 [Show id, title]
-->

SELECT id, title
 FROM movie
 WHERE yr=1962




<!--

When was Citizen Kane released?
2.
Give year of 'Citizen Kane'.

-->

select year from movie where title='Citizen Kane'



<!--

3.
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
-->












<!--
id for actor Glenn Close
4.
What id number does the actor 'Glenn Close' have?
-->

select id from actor where name='Glenn Close'








<!--
id for Casablanca
5.
What is the id of the film 'Casablanca'

-->

select id from movie where title='Casablanca'






<!--
Cast list for Casablanca
6.
Obtain the cast list for 'Casablanca'.

what is a cast list?
The cast list is the names of the actors who were in the movie.

Use movieid=11768, (or whatever value you got from the previous question)

-->


select name from actor where id in (select actorid from casting where movieid=11768) 






<!--

Alien cast list
7.
Obtain the cast list for the film 'Alien'

-->

select name from actor where id in (select actorid from casting where movieid=(select id from movie where title='Alien'))




<!--
Harrison Ford movies
8.
List the films in which 'Harrison Ford' has appeared

-->

select title from movie where id in (select movieid from casting where actorid=(select id from actor where name='Harrison Ford' ))




<!--

Harrison Ford as a supporting actor
9.
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
-->

select title from movie where id in (select movieid from casting where ord!=1 and actorid=(select id from actor where name='Harrison Ford'))




<!--

Lead actors in 1962 movies
10.
List the films together with the leading star for all 1962 films.
-->



SELECT title, name
FROM movie JOIN casting ON (id=movieid)
JOIN actor ON (actor.id = actorid)
WHERE ord=1 AND  yr = 1962







<!--

Busy years for John Travolta
11.
Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
-->

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)





<!--

Lead actor in Julie Andrews movies
12.
List the film title and the leading actor for all of the films 'Julie Andrews' played in.

Did you get "Little Miss Marker twice"?

-->

SELECT title, name FROM movie
JOIN casting x ON movie.id = movieid
JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting y
JOIN actor ON actor.id=actorid
WHERE name='Julie Andrews')
Submit SQLRestore default






<!--

Actors with 30 leading roles
13.
Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.

-->


select name from actor JOIN casting ON (id=actorid AND 

(select count(ord) from casting where actor.id=actorid and ord=1) >=30 ) 




<!--

14.
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
-->

select title,count(actor.name) as cnt from movie JOIN casting ON id=casting.movieid JOIN actor on casting.actorid=actor.id where yr=1978  GROUP by title order by cnt desc,title asc




<!--

15.
List all the people who have worked with 'Art Garfunkel'.

-->

SELECT DISTINCT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name

