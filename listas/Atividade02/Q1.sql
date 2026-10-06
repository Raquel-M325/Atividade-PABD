CREATE VIEW v_staff_performance AS 
SELECT 
    s.staff_id,
    s.first_name || ' ' || s.last_name AS nome_completo
