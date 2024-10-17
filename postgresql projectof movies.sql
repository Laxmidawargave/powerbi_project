Q-1: Write a SQL query to find the name and year of the movies. Return movie title, and movie release year.
code:
select* from movie;
Select movie_title,year
from movie;

Q-2: Write a SQL query to find when the movie 'Crazy' was released. Return movie release year.
code:
select movie_title , year from movie where movie_title='Crazy'


Q-3: Write a SQL query to find the movie that was released in 2017. Return movie title.
code:
select* from movie;
select movie_title,year
from movie
where year =2017;

Q-4: Write a SQL query to find those movies, which were released before 2019. Return movie title.
code:
select movie_title,year
from movie
where year < 2019
order by year;

Q-5: Write a SQL query to find all Movie_id who have an Avg_rating seven or more stars to their rating.
code:
select movie_id, Avg_rating
from ratings
where Avg_Rating>=7
order by Avg_Rating DESC;

Q-6: Write a SQL query to find the movie titles that contain the letters 'll'. Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year.
code:
select movie_id,movie_title,year from movie where movie_title like '%ll%'
order by year asc


Q-7:Â Write a SQL query to find those actors with the first name 'A' and the last name 'a' and the Movies_id they are known for. Return actor ID.
code:
select name_id,name,known_for_movies
from names
where name like 'A%a';



Q-8: Write a SQL query to find the movies with ID 'tt3405236' or 'tt5764024' or 'tt7820846'. Return movie title.
code:
select movie_title
from movie
where movie_id in('tt3625516','tt2556676','tt5119116')


Q-9 What genres of movies are there in the data set?
code:
select distinct(genre) as Name_of_Genre
from Genre;

Q-10 Show the avg_ratings of each movie.Sort the result-set in descending order by avg-rating.
code:
select movie_id,avg_rating
from ratings
order by avg_rating desc;

Q-11 Find the total number of movies released each year.
code:  
select count(movie_id) as Total_No_of_Movies,year
from Movie
group by year;

Q-12 How many movies were produced in the year 2019? 
code:
select year,count(movie_id) as No_of_Movies
from movie
group by year
having year = 2019;




Q-13 Which genre had the highest number of movies produced overall?
code:
select count(movie_id) as Total_No_of_Movies,Genre
from Genre
group by genre
order by Total_No_of_Movies desc
limit 1;

Q-14 What is the average duration of movies in each genre? 
code:
select Genre,round(avg(duration),2) as Avg_Duration_of_Movies
from Movie as M
Join Genre as G
on M.Movie_Id = G.Movie_Id
group by Genre;

Q-15 Find the minimum and maximum values in each column of the ratings table except the movie_id column.
code:
select max(Avg_Rating) as Max_AvgRating, Min(Avg_Rating) as Min_AvgRating,
max(Total_Votes) as Max_Votes, min(Total_Votes) as Min_Votes, 
Max(Median_Rating) as Max_MedianRating, Min(Median_Rating) as Min_MedianRating
from ratings;

Q- 16 How many movies were released in each genre during March 2018 and had votes of more than 1,000? ----------------no
code:
select * from movie
select * from genre 

Select G.Genre,count(M.Movie_Id) as No_of_Movies
from Movie as M
Join Genre as G
on M.Movie_Id = G.Movie_Id
Join ratings as R
on M.Movie_Id = R.Movie_Id
where M.year = 2018 and month(M.date_published)=3 and R.Total_Votes>1000
group by G.genre;

Q-17 Find movies of each genre that start with the word âBaâ and which have an average rating > 7. -------------no
code:
select M.Movie_Title,R.Avg_Rating
from movie as M
Join ratings as R
on M.Movie_Id=R.Movie_Id
where M.Movie_Title Like 'Ba%' and R.Avg_rating>7;

Q-18 No. of movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8? -------------no
code:
select count(M.Movie_Id) as No_of_Movies_Released,R.Median_Rating
from movie as m 
join ratings as R 
where M.date_published between "2018-04-01" and "2019-04-01" and Median_Rating=8
group by R.Median_Rating;

Q-19 Summarise the ratings table based on the movie counts by median ratings. 
code:
select Median_Rating, count(movie_id) as Movie_Count
from ratings
group by median_rating
order by Median_Rating Desc;

Q-20 Who are the top two actors whose movies have a median rating >= 8? --no
code:
select n.name as Actor_Name, count(rm.movie_id) as Movie_Count
from role_mapping as rm
join names as n
on rm.movie_id = n.Known_For_Movies
join ratings as r
on r.movie_id=rm.movie_id
where categpry = "actor" and median_rating >=8
group by n.name
order by movie_count desc
limit 2;
join ratings as r
on r.movie_id=rm.movie_id
where categpry = "actor" and median_rating >=8
group by n.name
order by movie_count desc
limit 2;

Q-21 What is the rank of the âthrillerâ genre of movies among all the genres in terms of number of movies produced? --no
code:
With Genre_Thriller_Rank as 
(Select Genre,Count(Movie_Id)as No_of_Movies,Dense_rank() over(order by count(Movie_Id) desc) as Genre_Rank
from genre
group by Genre)
select* from Genre_Thriller_Rank
where Genre = 'Thriller';

Q-22 Which are the top 10 movies based on average rating?
code:
select Movie_Title,Avg_Rating,Dense_Rank() Over(order by Avg_Rating desc) as Movie_Rank
from ratings as R
Join Movie as M
on M.Movie_Id = R.Movie_Id
limit 10;

Q-23 Which production house has produced the most number of hit movies (average rating > 7)?
code:
select Production_Company,Avg_Rating,count(M.Movie_Id) as No_Of_Movies,
rank() over(order by count(M.Movie_id) desc) as Production_Company_Rank
from movie as M
join ratings as R
on M.Movie_Id = R.Movie_Id
where R.Avg_Rating>=7
group by M.Production_Company,Avg_Rating;

Q-24 Which are the top three production houses based on the number of votes received by their movies?
code:
select M.Production_Company,sum(Total_Votes) as No_of_Votes, 
Dense_rank() Over(Order by sum(Total_Votes) desc) as Production_Company_Rank
from movie as M
Join ratings as R
on M.Movie_Id = R.Movie_Id
group by Production_Company
order by No_of_Votes desc
limit 3;

Q-25 Rank actors based on their average ratings.  --------------------no
code:
WITH rank_actors AS ( SELECT NAME AS actor_name, Sum(total_votes) AS total_votes, Count(RM.movie_id) AS movie_count, 
Round(Sum(avg_rating * total_votes) / Sum(total_votes), 2) AS actor_avg_rating 
FROM role_mapping RM 
JOIN names N
ON RM.name_id = N.name_id
JOIN ratings R
ON RM.movie_id = R.movie_id 
JOIN movie M
ON RM.movie_id = M.movie_id 
where categpry = 'actor'
group by actor_name)
SELECT *, DENSE_Rank() OVER (ORDER BY actor_avg_rating DESC) AS actor_rank FROM rank_actors;

-- Q-26 Find out the top five actresses based on their average ratings.
code:
select name as Actress_Name,Sum(Total_Votes) as Total_Votes,count(M.Movie_Id) as Movie_count,
round(sum(avg_rating*total_votes)/sum(total_votes),2) as Actress_Avg_Rating,
Dense_rank() over(order by round(sum(avg_rating*total_votes)/sum(total_votes),2) desc) as Actress_Rank
from role_mapping as RM
join names as N
on RM.name_id = N.name_id
join ratings as R
on RM.Movie_id = R.Movie_id
join movie as M
on RM.Movie_id = M.Movie_id
where categpry = 'Actress'
group by Actress_Name
LIMIT 5;

Q-27 Select drama movies as per avg rating and classify them in the following category:
     Rating > 8: Superhit movies
     Rating between 7 and 8: Hit movies
     Rating between 5 and 7: One-time-watch movies
     Rating < 5: Flop movies
code:
   select Movie_Title,Avg_rating,
   case
      when avg_rating > 8 then 'Superhit Movies'
      when avg_rating between 7 and 8 then 'Hit Movies'
      when avg_rating between 5 and 7 then 'One-Time-Watch Movies'
      when avg_rating < 5 then 'Flop Movies'
    end as "Movies Status"
    from ratings as R join movie as M on R.Movie_Id = M.Movie_id
    join genre as G on R.Movie_Id = G.Movie_Id
    where genre = 'Drama'
    order by Avg_rating desc;   

Q-28 What is the genre-wise running total and moving average of the average movie duration?
code:
SELECT genre, ROUND(AVG(duration),2) AS avg_duration, 
SUM(AVG(duration)) OVER(ORDER BY genre) AS running_total_duration, 
AVG(AVG(duration)) OVER(ORDER BY genre) AS moving_avg_duration 
FROM movie m 
JOIN genre g 
ON m.movie_id = g.movie_id 
GROUP BY genre;

Q-29 Which are the five highest-grossing movies of each year that belong to the top 2 genres?    ----------------no
code:
With Top_2_Genre as (
Select genre,count(Movie_id) as Movie_Count,rank() over (order by count(Movie_Id) desc) as genre_rank 
from genre 
group by genre
limit 2),
Movies_Rank As (Select Genre,Movie_Title,Year,WorldWide_Gross_Income,rank() over(order by worldwide_gross_income desc) as WorldWide_Income_Rank
from movie as M
Join genre as G
on M.movie_Id = G.movie_Id
where genre in (select genre from Top_2_Genre) ) 

SELECT * FROM Movies_Rank WHERE WorldWide_Income_Rank<=5;

Q-30 Which are the top three production houses that have produced the highest number of hits (median rating >= 8)?
code:
select Production_Company,Count(M.Movie_Id) as Movie_Count,
Row_Number() over(order by count(M.Movie_Id) desc) as Prod_Comp_Rank,Median_Rating
from Movie as M
Join Ratings as R
on M.movie_id = R.movie_id
where median_rating >=8
group by Production_Company,Median_Rating
limit 3;

Q-31 Who are the top actresses based on a number of Super Hit movies (average rating >8) in the drama genre? - Advanced
code:
select Distinct(genre) from genre;
SELECT name as actress_name, SUM(total_votes) AS total_votes, COUNT(rm.movie_id) as movie_id, 
Round(Sum(avg_rating * total_votes)/Sum(total_votes),2) AS actress_avg_rating, 
DENSE_RANK() OVER(ORDER BY COUNT(rm.movie_id) DESC) AS actress_rank 
FROM names as n 
JOIN role_mapping rm 
ON n.name_id = rm.name_id 
JOIN ratings r 
ON r.movie_id = rm.movie_id 
JOIN genre g 
ON g.movie_id = r.movie_id 
WHERE categpry='actress' AND avg_rating>=8 AND g.genre='Drama' 
GROUP BY name;

alter table  tole_mapping rename to role_mapping

16 18 20 29

