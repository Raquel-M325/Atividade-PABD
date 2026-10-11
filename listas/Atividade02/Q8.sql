create table film_cost_audit(
    film_id integer primary key not null,
    old_cost decimal(10,2),
    new_cost decimal(10,2),
    changed_at timestamp default current_timestamp
);


create or replace function audit_film_cost()
returns trigger as $$
begin
    insert into film_cost_audit(film_id, old_cost, new_cost)
    values(new.film_id, old.replacement_cost, new.replacement_cost);

    return new;
end;
$$ language plpgsql;


create trigger trg_film_cost_audit
after update on film
for each row
when (replacement_cost is distinct from new.replacement_cost)
execute function audit_film_cost();