create table customer_rental_stats (
    customer_id integer primary key not null,
    total_rentals integer default 0
);

insert into customer_rental_stats (customer_id, total_rentals)
select customer_id, count(*) as total_rentals
from rental
group by customer_id;

create or replace function update_customer_rental_stats()
returns trigger as $$
begin
    if exists (
        select 1
        from customer_rental_stats
        where customer_id = new.customer_id
    ) then
        update customer_rental_stats
        set total_rentals = total_rentals + 1
        where customer_id = new.customer_id;
    else
        insert into customer_rental_stats (customer_id, total_rentals)
        values (new.customer_id, 1);
    end if;

    return new;
end;
$$ language plpgsql;

create trigger trg_customer_rental_stats
after insert on rental
for each row
execute function update_customer_rental_stats();