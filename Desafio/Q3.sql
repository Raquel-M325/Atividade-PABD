create or replace function impede_exclusao_trigger()
returns trigger as $$
begin
    if exists (select 1 from race_data where driver_id = OLD.driver_id) then
        raise exception ' %: Exclusão não permitida', OLD.driver_id;
    end if;

    return OLD;
end;
$$ language plpgsql;

create trigger impede_exclusao
before delete on season_driver_standing
for each row
execute function impede_exclusao_trigger();