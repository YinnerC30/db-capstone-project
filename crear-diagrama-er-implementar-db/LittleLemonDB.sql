create table LittleLemonDB.categories_menu
(
    category_menu_id int         not null comment 'Identificador de la categoría del menú'
        primary key,
    name             varchar(50) not null comment 'Nombre de la categoría del menú'
)
    comment 'Categorías existentes en el menú del restaurante';

create table LittleLemonDB.customers
(
    customer_id  int          not null comment 'Identificador del cliente'
        primary key,
    name         varchar(100) null comment 'Nombre del cliente',
    email        varchar(50)  not null comment 'Correo electrónico del cliente',
    phone_number varchar(10)  not null comment 'Número de teléfono del cliente'
)
    comment 'Información de los clientes del restaurante';

create table LittleLemonDB.menu
(
    name             varchar(50) not null comment 'Nombre del elemento del menú',
    menu_id          int         not null comment 'Identificador del elemento del menu'
        primary key,
    price            decimal     not null comment 'Precio correspondiente a una unidad del elemento del menu',
    category_menu_id int         not null comment 'Identificador de la categoría a la cual pertenece el elemento del
menu
',
    constraint menu_categories_menu_category_menu_id_fk
        foreign key (category_menu_id) references LittleLemonDB.categories_menu (category_menu_id)
)
    comment 'Información de los productos que ofrece el restaurante
para consumir';

create table LittleLemonDB.positions
(
    position_id int         not null comment 'Identificador del puesto de trabajo'
        primary key,
    name        varchar(50) not null comment 'Nombre del puesto de trabajo',
    salary      decimal     not null comment 'Salario del puesto de trabajo'
)
    comment 'Información de los puestos de trabajo';

create table LittleLemonDB.staff
(
    staff_id     int          not null comment 'Identificación del empleado'
        primary key,
    name         varchar(100) not null comment 'Nombre del empleado',
    position_id  int          not null comment 'Identificador del puesto de trabajo que tiene el empleado',
    email        varchar(50)  not null comment 'Correo electrónico del empleado',
    phone_number varchar(10)  not null comment 'Número de teléfono del empleado',
    constraint staff_positions_position_id_fk
        foreign key (position_id) references LittleLemonDB.positions (position_id)
)
    comment 'Información de los empleados del restaurante';

create table LittleLemonDB.status_delivery
(
    status_delivery_id int         not null comment 'Identificador del estado de pedido'
        primary key,
    name               varchar(50) not null comment 'Nombre del estado de pedido'
)
    comment 'Estados de entrega de los pedidos';

create table LittleLemonDB.tables
(
    table_id int         not null comment 'Identificador de la mesa'
        primary key,
    name     varchar(50) not null comment 'Nombre característico de la mesa'
)
    comment 'Información sobre las mesas del restaurante';

create table LittleLemonDB.bookings
(
    booking_id  int      not null comment 'Identificador de la reservación'
        primary key,
    date        datetime not null comment 'Fecha y hora en la cual se realizo la reservación',
    table_id    int      null comment 'Identificador de la mesa a la cual corresponde la reservación',
    customer_id int      not null comment 'Identificador del cliente que realizo la reservación',
    constraint bookings_customers_customer_id_fk
        foreign key (customer_id) references LittleLemonDB.customers (customer_id),
    constraint bookings_tables_table_id_fk
        foreign key (table_id) references LittleLemonDB.tables (table_id)
)
    comment 'Encargada de almacenar las reservaciones del restaurante';

create table LittleLemonDB.orders
(
    order_id    int     not null comment 'Identificador del pedido'
        primary key,
    quantity    int     not null comment 'Cantidad del alimento a preparar',
    total       decimal not null comment 'Costo total a pagar por el pedido',
    customer_id int     not null comment 'Identificador del cliente que solicito el pedido',
    staff_id    int     not null comment 'Identificador del empleado que atendió el pedido',
    menu_id     int     not null comment 'Identificador del elemento del menú que se solicito en el pedido',
    table_id    int     not null comment 'Identificador de la mesa donde se solicito el pedido',
    constraint orders_customers_customer_id_fk
        foreign key (customer_id) references LittleLemonDB.customers (customer_id),
    constraint orders_menu_menu_id_fk
        foreign key (menu_id) references LittleLemonDB.menu (menu_id),
    constraint orders_staff_staff_id_fk
        foreign key (staff_id) references LittleLemonDB.staff (staff_id),
    constraint orders_tables_table_id_fk
        foreign key (table_id) references LittleLemonDB.tables (table_id)
)
    comment 'Información de los pedidos realizados al restaurante';

create table LittleLemonDB.delivery_orders
(
    delivery_id        int      not null comment 'Identificación del registro de entrega de pedido'
        primary key,
    order_id           int      not null comment 'Identificador del pedido',
    date_delivery      datetime not null comment 'Fecha de entrega del pedido',
    date_entry         datetime not null comment 'Fecha de recepción del pedido',
    status_delivery_id int      not null comment 'Identificación del estado de entrega del pedido',
    constraint delivery_orders_order_id_fk
        foreign key (order_id) references LittleLemonDB.orders (order_id),
    constraint delivery_status_delivery_status_delivery_id_fk
        foreign key (status_delivery_id) references LittleLemonDB.status_delivery (status_delivery_id)
)
    comment 'Información de entrega de pedidos';

