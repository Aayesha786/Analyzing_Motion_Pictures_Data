-- Task 1 ( Display the first_name,last_name,actor_id,last_update)
use sakila;
select * from actor;

/* The Query displays  first_name,last_name,actor_id,last_updated column 
from actors table using SELECT from sakila database */


----- Task 2 (a) Display the full names of all actors
select concat(first_name,' ',last_name)as 'Employee Full Name' from actor;

/* The Query displays full names of all actors using CONCAT  from actors table */


----- Task 2(b) Display the first_names of actors along with count of repeated first_names
select first_name,count(first_name) as Count_of_Firstnames from actor 
group by first_name 
having count(first_name)>1;

/* The Query displays first_names by GROUP BY and their count using COUNT   
who are repeated more than once using HAVING */


-- Task 2(c) Display the last_names of actors along with count of repeated last_names
select last_name,count(last_name) as Count_of_Lastnames from actor 
group by last_name 
having count(last_name)>1;

/* The Query displays last_names  by GROUP BY and their count  using COUNT 
who are repeated more than once using HAVING  */



-- Task 3 (Display the count of movies group by ratings)
select rating,count(*) as count from film group by rating;

/* The Query displays the count of movies grouped by ratings using GROUP BY and COUNT(*) to get count of rating */


-- Task 4 (Display the average rental rates based on ratings)
select rating,avg(rental_rate) as Avg_of_rental_rate from film group by 1;

/* The Query displays the average of rental_rates grouped by ratings 
using GROUP BY and avg to get Average of rental_rates */


-- Task 5 (a) Display the movie titles where replacement_cost is up to $9
select title as Movie_Titles,replacement_cost from film where replacement_cost between 0 and 9;

/* The Query displays the movie titles where replacement cost is between 0 to 9 */


-- 5(b) Display the movie titles where replacement_cost is between 15 and 20
select title as Movie_Titles,replacement_cost from film where replacement_cost between 15 and 20;

/* The Query displays the movie titles where replacement cost is between 15 and 20 */

-- 5(c)Display the movie titles with highest replacement_cost and lowest rental cost
-- Rental cost = rental _rate * rental_duration
select film.title as Movie_Titles,max(replacement_cost) as MAX_replacement_cost,
min(film.rental_rate * film.rental_duration) as Min_rental_cost from film
group by 1  
order by 2 desc,
3 asc;

/* The Query displays the movie titles with high replacement cost using MAX and lowest rental_cost 
using MIN using GROUP BY title  and sorting using ORDER BY highest DESC and lowest ASC */


-- Task 6 (Display the list all the movies along with number of actors listed from each movie)
select f.title as Movie_Titles,count(*) as Number_of_actors from film f 
inner join film_actor fc on f.film_id=fc.film_id 
group by f.title;

/* The Query displays the list all the movies with count of actors using COUNT from each movie and GROUP BY title */

-- Task 7( Display the movie titles starting with letters K and Q) 
select title as Movies from film where title like 'k%' or title like 'q%';

/* The Query displays the movie titles starting with letters K and Q 
using LIKE operator to retrive movies that start with K and Q */


-- Task 8 ( Display first_name and last_name of all actors who acted in 'AGENT TRUMAN' movie)
select actor.first_name,actor.last_name from actor
 join film_actor using (actor_id) 
 join film using (film_id)  
 where title = 'AGENT TRUMAN';
 
 /* The Query displays first_name ,last_name of all actors that acted in  'AGENT TRUMAN' movie' 
 by combining three tables actor,film_actor, fim based on common primary key*/

-- Task 9 (Identify and Display the names of the movies in the family and children category)
select film.title as 'Children & Family Movies' from film  
join  film_category using (film_id )
join category using (category_id)
where category.name in ('children','family');

/* The Query displays the names of all movies from family and children category 
by combining three tables film, fim_category,category based on common primary key */
   
   -- Task 10 (Display the names of most frequently rented movies in descending order)
   select film.title as Movie_Names,count(rental.rental_id) as Rental_count from film 
   join inventory using   (film_id) 
   join rental using (inventory_id) 
   group by 1
   order by 2 desc;
   
   /*The Query displays the Movie names that are most frequently rented movies grouping by title
   using GROUP BY and sorting using ORDER BY rental_cost */
   
   
/* Task 11 (Display the number of movie categories where 
average difference between movie replacement_cost and rental_rate is greater than 15)*/
create view  category_avg_diff as
select  category.name, AVG(film.replacement_cost - film.rental_rate) as avg_diff
from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
group by category.name;
select * from category_avg_diff;

/*  Creating a view called category_avg_diff to store category names,avg of replacement cost and low rental rate by combining 
three tables category,fim_category,film */

select COUNT(*) as number_of_categories
from category_avg_diff
where avg_diff > 15;
select *from film;

/* The Query displays the count of categories from view called category_avg_diff where 
 average difference between movie replacement_cost and rental_rate is greater than 15*/

----- Task 12 (Display the names of categories and the number of movies per category sorted by number of movies)
select category.name as Category_name,count(film_category.film_id)as Movie_count from category 
join film_category using(category_id) 
group by 1
order by 2 desc; 

/*  The Query displays names of categories and their count using COUNT grouped by name using  GROUP BY  sorted by ORDER BY 
by combining two tables category and film_category based on common primary key */