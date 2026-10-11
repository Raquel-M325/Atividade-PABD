-- habilita a entensao para que usa a forma trigram para indexar a coluna description da tabela film
create extension if not exists pg_trgm;

create index idx_film_description_trgm
on film
using gin (description gin_trgm_ops);

select *
from film
where description like '%documentary%' 
OR description like '%drama%';

explain analyze
select *
from film
where description like '%documentary%' 
OR description like '%drama%';