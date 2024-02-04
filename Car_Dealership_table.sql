CREATE TABLE Customers (
  customer_id SERIAL primary key,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone_number VARCHAR(20),
  email_address VARCHAR(20),
  address VARCHAR(50),
  payment VARCHAR(50)
);

CREATE TABLE Car (
  car_id SERIAL primary key,
  price NUMERIC(7,2),
  model VARCHAR(30),
  new_car BOOLEAN,
  customer_id INTEGER,
  foreign key(customer_id) references Customers(customer_id)
);

CREATE TABLE Mechanics (
  mec_id SERIAL primary key,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone_number VARCHAR(20)
);

CREATE TABLE Service_Ticket (
  service_ticket_id SERIAL primary key,
  service_done VARCHAR(30),
  service_total NUMERIC(6,2),
  service_date DATE,
  mec_id INTEGER,
  car_id INTEGER,
  foreign key(car_id) references Car(car_id),
  foreign key(mec_id) references Mechanics(mec_id)
);

CREATE TABLE SalesStaff (
  salesstaff_id SERIAL primary key,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone_number VARCHAR(20),
  email_address VARCHAR(20)
);

CREATE TABLE Invoice (
  invoice_id SERIAL primary key,
  invoice_date DATE,
  salesstaff_id INTEGER,
  car_id INTEGER,
  foreign key(salesstaff_id) references SalesStaff(salesstaff_id),
  foreign key(car_id) references Car(car_id)
);



-- changed from varchar to varchar(100)
alter table Customers
alter column email_address type varchar(100);

alter table car 
alter column model type varchar(100);

alter table service_ticket
alter column service_done type varchar(200);

