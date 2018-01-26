SUM and COUNT
Language:	English  • 中文
Contents [hide] 
1	World Country Profile: Aggregate functions
2	You might want to look at these examples first
3	Total world population
4	List of continents
5	GDP of Africa
6	Count the big countries
7	Baltic states population
8	Using GROUP BY and HAVING
9	Counting the countries of each continent
10	Counting big countries in each continent
11	Counting big continents
World Country Profile: Aggregate functions
This tutorial is about aggregate functions such as COUNT, SUM and AVG. An aggregate function takes many values and delivers just one value. For example the function SUM would aggregate the values 2, 4 and 5 to deliver the single value 11.

name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...
You might want to look at these examples first
Using SUM, Count, MAX, DISTINCT and ORDER BY.







Total world population
1.
Show the total population of the world.

world(name, continent, area, population, gdp)

select SUM(population)
from world










List of continents
2.
List all the continents - just once each.


select distinct continent from world








3.
Give the total GDP of Africa


select sum(gdp) from world where continent='Africa'












4.
How many countries have an area of at least 1000000


select count(name) from world where area >= 1000000











Baltic states population
5.
What is the total population of ('Estonia', 'Latvia', 'Lithuania')


select sum(population) from world where name in  ('Estonia', 'Latvia', 'Lithuania')








Counting the countries of each continent
6.
For each continent show the continent and number of countries.


select continent,count(name) from world group by continent











Counting big countries in each continent
7.
For each continent show the continent and number of countries with populations of at least 10 million.


select continent,count(name) from world where population >=10000000 group by continent












Counting big continents
8.
List the continents that have a total population of at least 100 million.


select continent from world group by continent having 
sum(population) >=100000000 

