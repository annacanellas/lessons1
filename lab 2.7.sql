-- lab student portal 2.07
-- lab lesson 2.06
drop table if exists films_2020;

CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

show variables like 'local_infile';
set global local_infile = 1;

load data local infile './files_for_lab/films_2020.csv' 
into table films_2020
fields terminated BY ',';

update films_2020
set rental_duration = 3, rental_rate = 2.99, replacement_cost = 8.99
where description = 2020;

-- lab lesson 2.07
-- 1. In the table actor, which are the actors whose last names are not repeated?
select first_name, last_name,count(*) from sakila.actor
group by last_name
having count(*)=1;
-- 2.Which last names appear more than once? 
select last_name, count(*) from sakila.actor
group by last_name
having count(*)>1;
-- 3.Using the rental table, find out how many rentals were processed by each employee.
select staff_id, count(rental_id) from rental
group by staff_id;
-- 4. Using the film table, find out how many films were released each year.
select release_year, count(film_id) from film
group by release_year;

-- 5.Using the film table, find out for each rating how many films were. there.
select rating, count(film_id) from film
group by rating;
-- 6.What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
select rating, round(avg(length),2) as avg_duration from film
group by rating;
-- 7.Which kind of movies (rating) have a mean duration of more than two hours?
select rating, round(avg(length), 2)/60 avg_duration from film
group by rating;