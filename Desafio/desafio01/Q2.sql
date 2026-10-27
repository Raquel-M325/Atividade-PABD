DROP TABLE IF EXISTS points_adjustment_audit;
CREATE TABLE points_adjustment_audit (
    id         SERIAL PRIMARY KEY,
    year       INT NOT NULL,
    driver_id  VARCHAR(100) NOT NULL,
    old_points DECIMAL(8,2),
    new_points DECIMAL(100,2),
    changed_at TIMESTAMPTZ DEFAULT NOW()
);

create or replace function log_points_adjustment() 
returns trigger as $$
begin
    insert into points_adjustment_audit (year, driver_id, old_points, new_points)
    values (OLD.year, OLD.driver_id, OLD.points, NEW.points);
    return NEW;
end;
$$ language plpgsql;


create trigger season_driver_standing
after update on season_driver_standing --apenas quando houver mudança real
for each row
when (OLD.points <> NEW.points) -- quando houver mudança real nos pontos
execute function log_points_adjustment();