create table customer (
    id int primary key,
    name varchar(255),
    email varchar(255),
    endereco varchar(255),
    telefone varchar(20)
);

insert into customer (id, name, email, endereco, telefone) values 
    (1, 'John Doe', 'john.doe@example.com', '123 Main St', '555-1234');

select * from customer;

rollback;

--porque isso é uma medida de segurança para não confirmar a transação automaticamente
--se houver algum erro ou se a operação não for desejada, podemos desfazer a transação com o rollback
--isso ajuda a manter a integridade dos dados e a evitar alterações indesejadas no banco de dados