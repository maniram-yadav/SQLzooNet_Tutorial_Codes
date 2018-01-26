SELECT from Nobel Tutorial
Language:	English  • 中文
nobel
yr	subject	winner
1960	Chemistry	Willard F. Libby
1960	Literature	Saint-John Perse
1960	Medicine	Sir Frank Macfarlane Burnet
1960	Medicine	Peter Madawar
...
Contents [hide] 
1	nobel Nobel Laureates
2	Winners from 1950
3	1962 Literature
4	Albert Einstein
5	Recent Peace Prizes
6	Literature in the 1980's
7	Only Presidents
8	John
9	Chemistry and Physics from different years
10	Exclude Chemists and Medics
11	Early Medicine, Late Literature
12	Harder Questions
13	Umlaut
14	Apostrophe
15	Knights of the realm
16	Chemistry and Physics last










<--
Winners from 1950
1.
Change the query shown so that it displays Nobel prizes for 1950.
-->

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950









<--
2.
Show who won the 1962 prize for Literature.
-->

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'






<--
3.
Show the year and subject that won 'Albert Einstein' his prize.
-->

select yr,subject from nobel
   where winner='Albert Einstein'






<--
4.
Give the name of the 'Peace' winners since the year 2000, including 2000.
-->


select winner from nobel
   where subject='Peace' and yr>1999





<--
5.
Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
-->

select * from nobel
   where subject='Literature' and yr between 1980 and 1989










<--
6.
Show all details of the presidential winners:

-->


SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                   'Barack Obama')






<--
7.
Show the winners with first name John
-->

SELECT winner FROM nobel
 WHERE winner like 'John%'







<--
8.
Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
-->

select yr,subject,winner from  nobel
   where subject='Physics' and yr=1980
   or subject='Chemistry' and yr=1984


<--
9.
Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
-->

select yr,subject,winner from  nobel
   where yr=1980 and subject not in ('Chemistry','Medicine')



<--
10.
Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
-->

select yr,subject,winner from  nobel
   where subject='Medicine' and yr<1910
   or  subject='Literature' and yr>2003





<--
11.
Find all details of the prize won by PETER GRÜNBERG

Non-ASCII characters
The u in his name has an umlaut. You may find this link useful https://en.wikipedia.org/wiki/%C3%9C#Keyboarding
-->

select yr,subject,winner from  nobel
   where winner='PETER GRÜNBERG'





<--
12.
Find all details of the prize won by EUGENE O'NEILL

Escaping single quotes

select yr,subject,winner from  nobel
   where winner='EUGENE O\'NEILL'




<--
13.
Knights in order

List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
-->

select winner,yr,subject from  nobel
   where winner like 'Sir%'




<--
14.
The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.

Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
-->


SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'),subject,winner 

