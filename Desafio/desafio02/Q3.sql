-- sessao A
insert into inventory (id, name, quantity, price, description) values 
    (1, 'Item 1', 10, 100.00, 'Description for Item 1');
commit;

-- sessao B
delete from inventory   
where id = 1;

commit;