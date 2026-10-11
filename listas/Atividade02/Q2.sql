create materialized view mv_category_total_sales as
select
    c.name as categoria,
    c.category_id,
    SUM(p.amount) as total_receita

from category as c

inner join film_category as fc 
    on c.category_id = fc.category_id

inner join inventory as i
    on fc.film_id = i.film_id

inner join rental as r
    on i.inventory_id = r.inventory_id

inner join payment as p
    on r.rental_id = p.rental_id

group by 
    c.name,
    c.category_id;

create unique index idx_mv_category_total_sales
on mv_category_total_sales(categoria);

refresh materialized view concurrently mv_category_total_sales;


