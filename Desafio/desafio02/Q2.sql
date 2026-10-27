create table inventory (
    id int primary key,
    name varchar(255),
    quantity int,
    price decimal(10,2),
    description varchar(255)

);

select * from inventory;

savepoint estoque_atualizado;

insert into inventory (id, name, quantity, price, description) values 
    (1, 'Item 1', 10, 100.00, 'Description for Item 1');

rollback to estoque_atualizado;

commit;

--a vantagem de usar savepoint é que tudo que for feito após o savepoint pode ser revertido, sem afetar as alterações anteriores.
