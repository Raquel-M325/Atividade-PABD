CREATE VIEW v_staff_performance AS 
SELECT 
    s.staff_id, 
    s.first_name || ' ' || s.last_name AS nome_completo,
    c.city || ' ' || c.country AS localizacao,
    COALESCE(r.total_locacoes, 0) AS total_locacoes,
    COALESCE(p.total_arrecadado, 0) AS total_arrecadado

FROM staff AS s

LEFT JOIN store AS st
    ON s.store_id = st.store_id

LEFT JOIN address AS ad
    ON st.address_id = ad.address_id

LEFT JOIN city AS c
    ON ad.city_id = c.city_id

LEFT JOIN country AS co
    ON c.country_id = co.country_id

LEFT JOIN (
    SELECT staff_id, COUNT(*) AS total_locacoes
    FROM rental
    GROUP BY staff_id

) AS r
    ON s.staff_id = r.staff_id

LEFT JOIN (
    SELECT staff_id, SUM(amount) AS total_arrecadado
    FROM payment
    GROUP BY staff_id
) AS p
    ON s.staff_id = p.staff_id;


