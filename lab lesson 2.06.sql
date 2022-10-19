-- lab student portal 2.06
-- lab lesson 2.04:
-- Lab 2.04
-- 1. Get film ratings.
select distinct rating from film;
-- 2. Get release years.
select distinct release_year from film;
-- 3. Get all films with ARMAGEDDON in the title.
select * from film
where title regexp 'ARMAGEDDON';
-- 4. Get all films with APOLLO in the title
select * from film
where title regexp 'APOLLO';
-- 5. Get all films which title ends with APOLLO.
select * from film
where title regexp 'APOLLO$';
-- 6. Get all films with word DATE in the title.
select * from film
where title regexp 'DATE';
-- 7. Get 10 films with the longest title.
select * from film
order by length(title) desc
limit 10;
-- 8. Get 10 the longest films.
select * from film
order by length desc
limit 10;
-- 9. How many films include Behind the Scenes content?
select count(*) from film
where special_features like '%Behind the Scenes%';
-- 10. List films ordered by release year and title in alphabetical order.
select * from film
order by release_year, title;

-- lab lesson 2.05
-- 1. alter table sakila.staff drop column picture;
select * from sakila.staff;
-- 2. to check if such an entry already exists
select * from sakila.customer
where first_name = 'TAMMY' and last_name = 'SANDERS';

insert into sakila.staff(first_name, last_name, email, address_id, store_id, username)
values('TAMMY','SANDERS', 'TAMMY.SANDERS@sakilacustomer.org', 79, 2, 'tammy');

select * from sakila.staff;
-- 3. get customer_id
select customer_id from sakila.customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- expected customer_id = 130

-- get film_id
select film_id from sakila.film where title='ACADEMY DINOSAUR';
-- expected film_id = 1
-- get inventory_id
select inventory_id from sakila.inventory where film_id = 1;
-- expected inventory_id = 1

-- get staff_id
select staff_id from sakila.staff
where first_name='Mike' and last_name='Hillyer';
-- expected staff_id = 1

insert into sakila.rental(rental_date, inventory_id, customer_id, staff_id)
values (curdate(), 1, 130, 1);

select * from sakila.rental
where customer_id=130;
-- 4. check the current number of inactive users
select * from sakila.customer
where active = 0;

drop table if exists deleted_users;

CREATE TABLE deleted_users (
customer_id int UNIQUE NOT NULL,
email varchar(255) UNIQUE NOT NULL,
delete_date date
);

insert into deleted_users
select customer_id, email, curdate()
from sakila.customer
where active = 0;

select * from deleted_users;

delete from sakila.customer where active = 0;

-- check how many inactive users there are now
select * from sakila.customer
where active = 0;
