-- Liste os produtos com preço superior a R$ 1000.
select name, price from products
where price > 1000;


-- Liste os produtos ordenados pelo preço, do maior para o menor.
select name, price from products
order by price DESC; 


-- Aumente o preço de todos os produtos da Dell em 10%.
update products 
set price = price * 1.10
where name like '%Dell%';
select name, price from products;


-- Exclua todos os produtos que sejam do tipo Macbook.
delete from products
where name like '%Macbook%';
select name, price from products;


-- Exclua um produto que não possua pedidos associados.
delete from products
where not exists (
    select 1 -- dá uma resposta
    from orders_products -- acessa os pedidos associados
    where orders_products.product_id = product_id --vê se o id do produto está o mesmo no pedido associado
);
select price, name from products;


-- Liste todos os pedidos realizados nos últimos 30 dias.
select * from orders
where order_date >= now() - interval '30 days';


-- Liste os pedidos e os respectivos nomes de usuário.
select user.name,  from orders


-- Liste todos os usuários e seus pedidos, inclusive usuários sem pedidos.
select 