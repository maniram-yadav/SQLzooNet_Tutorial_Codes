SELECT from WORLD Tutorial
Language:	English  • 中文
name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...

In this tutorial you will use the SELECT command on the table world:

Contents [hide] 
1	Introduction
2	Large Countries
3	Per capita GDP
4	South America In millions
5	France, Germany, Italy
6	United
7	Two ways to be big
8	One or the other (but not both)
9	Rounding
10	Trillion dollar economies
11	Name and capital have the same length
12	Matching name and capital
13	All the vowels
14	What Next










<--
1.
Read the notes about this table. Observe the result of running this SQL command to show the name, continent and population of all countries.
-->

SELECT name, continent, population FROM world













<--
2.
How to use WHERE to filter records. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
-->

SELECT name FROM world
WHERE population >= 200000000







<--
3.
Give the name and the per capita GDP for those countries with a population of at least 200 million.
-->

select name,gdp/population from world where population>=200000000



<--


4.
Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
-->


select name,population/1000000 from world where
 continent='South America'








<--
5.
Show the name and population for France, Germany, Italy
-->


select name,population from world where name in ('France','Germany','Italy')




<--
6.
Show the countries which have a name that includes the word 'United'
-->


select name from world where name like '%United%'





<--
7.
Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.

Show the countries that are big by area or big by population. Show name, population and area.
-->



select name,population,area from world where area>3000000 or population>250000000








<--
8.
Exclusive OR (XOR). Show the countries that are big by area or big by population but not both. Show name, population and area.

Australia has a big area but a small population, it should be included.
Indonesia has a big population but a small area, it should be included.
China has a big population and big area, it should be excluded.
United Kingdom has a small population and a small area, it should be excluded.
-->


select name,population,area from world where (area>3000000 and population<=250000000) or (area<=3000000 and population>250000000) 







<--
9.
Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.

For South America show population in millions and GDP in billions both to 2 decimal places.
Millions and billions
Divide by 1000000 (6 zeros) for millions. Divide by 1000000000 (9 zeros) for billions.
-->


select name,ROUND(population/1000000,2),ROUND(gdp/1000000000,2) from world where continent='South America'











<--
10.
Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

Show per-capita GDP for the trillion dollar countries to the nearest $1000.
-->


select name,ROUND(gdp/(population*1000),0)*1000 from world where gdp>=1000000000000










<--
11.
Greece has capital Athens.

Each of the strings 'Greece', and 'Athens' has 6 characters.

Show the name and capital where the name and the capital have the same number of characters.

You can use the LENGTH function to find the number of characters in a string
-->


SELECT name,capital from world where LENGTH(name)=LENGTH(capital)










<--
12.
The capital of Sweden is Stockholm. Both words start with the letter 'S'.

Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
You can use the function LEFT to isolate the first character.
You can use <> as the NOT EQUALS operator.
-->


SELECT name,capital from world where STRCMP(name,capital)!=0 and capital like CONCAT(LEFT(name,1),'%')






<--
13.
Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.

Find the country that has all the vowels and no spaces in its name.

You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
The query shown misses countries like Bahamas and Belarus because they contain at least one 'a'
-->


SELECT name
   FROM world
where name not like '% %' and name like '%a%' and name  like '%e%' and name like '%i%' and name like '%o%' and name like '%u%'
Submit SQLRestore default
Correct answer
name
Mozambique
