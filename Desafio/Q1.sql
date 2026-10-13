create materialized view mv_driver_season_summary as

select
    a.ano,
    p.piloto,
    SUM(tc.totalcorridas) as totalcorridas,
    SUM(v.vitorias) as vitorias,
    SUM(pd.podios) as podios,
    SUM(ab.abandonos) as abandonos,
    SUM(tp.totalpontos) as totalpontos,
    SUM(rd.position_number) as position_number,
    COUNT(case when rd.position_number = 1 then 1 end) as first_place_count,
    COUNT(case when rd.position_number <= 3 then 1 end) as top_three_count,
    COUNT(case when ab.race_reason_retired is not NULL then 1 end) as retired_count

from race a
inner join driver p on a.driver_id = p.driver_id
inner join total_corridas tc on a.driver_id = tc.driver_id
inner join vitorias v on a.driver_id = v.driver_id
inner join podios pd on a.driver_id = pd.driver_id
inner join abandonos ab on a.driver_id = ab.driver_id
inner join total_pontos tp on a.driver_id = tp.driver_id

inner join race_data rd on a.race_id = rd.race_id

group by
    a.ano,
    p.piloto,
    SUM(tc.totalcorridas),
    SUM(v.vitorias),
    SUM(pd.podios),
    SUM(ab.abandonos),
    SUM(tp.totalpontos),
    SUM(rd.position_number),
    COUNT(case when rd.position_number = 1 then 1 end),
    COUNT(case when rd.position_number <= 3 then 1 end),
    COUNT(case when ab.race_reason_retired is not NULL then 1 end) ;


create unique index idx_mv_driver_season_summary
on mv_driver_season_summary(a.ano, p.piloto, SUM(tc.totalcorridas), SUM(v.vitorias), SUM(pd.podios), SUM(ab.abandonos), SUM(tp.totalpontos), COUNT(case when rd.position_number = 1 then 1 end), COUNT(case when rd.position_number <= 3 then 1 end), COUNT(case when ab.race_reason_retired is not NULL then 1 end));

refresh materialized view concurrently mv_driver_season_summary;
 
