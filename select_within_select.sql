SELECT within SELECT Tutorial
This tutorial looks at how we can use SELECT statements within SELECT statements to perform more complex queries.

name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...
Using nested SELECT

Summary
Contents [hide] 
1	Exercises
2	Bigger than Russia
3	Richer than UK
4	Neighbours of Argentina and Australia
5	Between Canada and Poland
6	Percentages of Germany
7	Bigger than every country in Europe
8	Largest in each continent
9	First country of each continent (alphabetically)
10	Difficult Questions That Utilize Techniques Not Covered In Prior Sections






Bigger than Russia
1.
List each country name where the population is larger than that of 'Russia'.

world(name, continent, area, population, gdp)


SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')











Richer than UK
2.
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

Per Capita GDP
The per capita GDP is the gdp/population

select name from world
    where continent='Europe' and (gdp/population) >
     (select gdp/population from world 
      where name='United Kingdom' 
      )












Neighbours of Argentina and Australia
3.

List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.


select name,continent from world
    where continent in (select continent from world where 
                         name='Argentina'
                          or name='Australia')
     order by name












Between Canada and Poland
4.
Which country has a population that is more than Canada but less than Poland? Show the name and the population.


select name,population from world
    where population between (select population+1 from world 
                        where name='Canada') and
                    (select population-1 from world 
                        where name='Poland')






Percentages of Germany
5.
Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

Decimal places
You can use the function ROUND to remove the decimal places.
Percent symbol %
You can use the function CONCAT to add the percentage symbol.

select name,CONCAT(ROUND(population*100/(select population 
               from world  where name='Germany'),0),'%') 
               from world where continent='Europe'













Bigger than every country in Europe
6.
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)


select name from world where gdp > (select max(gdp) 
                  from world where continent='Europe')
        








Largest in each continent
7.
Find the largest country (by area) in each continent, show the continent, the name and the area:


SELECT continent,name, area FROM world x
  WHERE area >= ALL (select area from world b where
       b.continent = x.continent and area>0 )









First country of each continent (alphabetically)
8.
List each continent and the name of the country that comes first alphabetically.


SELECT continent, name FROM world x
	where name <= ALL
		(SELECT name FROM world y
	        where y.continent=x.continent);












Difficult Questions That Utilize Techniques Not Covered In Prior Sections
9.
Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.



SELECT name, continent, population FROM world x
	WHERE 25000000 >= ALL
		(SELECT population FROM world y
			WHERE y.continent=x.continent);










10.
Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.



select name, continent from world x
	where population > ALL
		(SELECT 3*population from world y
	          where y.continent=x.continent and
                  x.name <> y.name);
