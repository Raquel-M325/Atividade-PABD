-- sessao A
insert into inventory (id, name, quantity, price, description) values 
    (10, 'Item 1', 10, 100.00, 'Description for Item 1');

rollback;
commit;

-- sessao B
delete from inventory   
where id = 10;

rollback;
commit;

-- o gestor A ficará tentando inserir o item 10, enquanto o gestor B tentará excluí-lo, resultando em um conflito de transações.