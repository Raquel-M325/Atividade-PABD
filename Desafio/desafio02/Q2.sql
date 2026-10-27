create table inventory (
    id int primary key,
    name varchar(255),
    quantity int,
    price decimal(10,2),
    description varchar(255)

);

select * from inventory;

commit;

--a vantagem de usar savepoint é que tudo que for feito após o savepoint pode ser revertido, sem afetar as alterações anteriores.
