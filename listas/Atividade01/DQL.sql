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
select users.name, orders.id from orders
join users on users.id = orders.user_id;


-- Liste todos os usuários e seus pedidos, inclusive usuários sem pedidos.
select users.name, orders.id from orders
left join users on users.id = orders.user_id;


-- Liste todos os usuários (id, nome e email) que realizaram pelo menos um pedido.
select users.id, users.name, users.email, orders.id from orders
join users on users.id = orders.user_id;


-- Liste produtos que nunca foram vendidos.
select name from products
where not exists (
    select *
    from orders_products
    where orders_products.product_id = products.id
);


-- Liste usuários que nunca realizaram pedidos.
select name from users
where not exists (
    select *
    from orders
    where orders.user_id = users.id
);


--Liste os produtos com preço acima da média em ordem decrescente.
select name, price from products
where price > (
    select avg(price) --tem que ser dessa forma de ordem para listar e saber da onde pegou
    from products
)
order by price DESC;


-- Liste a quantidade de pedidos realizados por cada usuário.
select users.id, users.name, count(orders.id) from users
join orders on users.id = orders.user_id
group by users.id, users.name;


-- Listar os três produtos mais vendidos.
select products.name, products.price, sum(orders_products.quantity) as total_Vendido from products
join orders_products on products.id = orders_products.product_id --para saber se realmente houve pedido antes
group by products.name, products.price
order by total_Vendido DESC
limit 3;


-- Gerar um relatório com: usuários, quantidade de pedidos e valor total comprado.
select users.name, count(DISTINCT orders.id) as quantidade_pedidos, sum(orders_products.unit_price * orders_products.quantity) as valor_total_comprado from users
join orders on users.id = orders.user_id
join orders_products on orders_products.order_id = orders.id
group by users.name
order by valor_total_comprado DESC;