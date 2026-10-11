--foi um estudo de uma funcao
create or replace function validar_rental()
returns trigger as $$
begin
    if NEW.return_data is not null 
        AND NEW.return_date < NEW.rental_date THEN
        raise exception 'A data de devolução não pode ser menor que a data de locação, sendo negativo';
    end if;

    return new;
end;
$$ language plpgsql;

create trigger rental
before insert or update on rental
for each row
execute function validar_rental();
