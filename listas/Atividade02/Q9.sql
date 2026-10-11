create or replace function delete_language_film()
returns trigger as $$
begin
    if exists (
        select 1
        from film
        where language_id = old.language_id or original_language_id = old.original_language_id
    ) then
        raise exception 'Não é possível deletar a linguagem pois existem filmes associados a ela.';
    end if;
    return old;
end;
$$ language plpgsql;

create trigger trg_language_film
before delete on language
for each row
execute function delete_language_film();