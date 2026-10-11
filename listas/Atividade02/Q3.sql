create index idx_rental_open
on rental(rental_id)
where return_date is null;

-- consulta
select *
from rental
where return_date is null;

-- vendo o indice sendo utilizado
explain analyze
select *
from rental
where return_date is null;