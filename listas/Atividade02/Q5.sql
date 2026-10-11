create index idx_payment_multi
on payment (customer_id, payment_date DESC);

SELECT * 
FROM payment 
WHERE customer_id = X 
ORDER BY payment_date DESC;

-- primeiro tem que ser pelo customer_id para ele localizar a tabela que vai ser utilizado para que depois de encontrar, pegar o payment_date e ordenar de forma decrescente, se não tiver o customer_id ele não vai conseguir localizar os registros e ordenar pelo payment_date.