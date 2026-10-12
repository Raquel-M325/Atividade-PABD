create index idx_customer_email_lower
on customer (lower(email));

select *
from customer
where lower(email) = 'MARY.SMITH@example.com';


explain analyze
select *
from customer
where lower(email) = 'MARY.SMITH@example.com';