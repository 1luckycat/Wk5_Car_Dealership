insert into customers (
	first_name,
	last_name,
	phone_number,
	email_address,
	address,
	payment
) values (
	'Mario',
	'Mario',
	'929-55-MARIO',
	'thesupermariobros@gmail.com',
	'1985-A Plumbers Way, Mushroom Kingdom',
	'gold coins'
), (
	'Luigi',
	'Mario',
	'929-55-LUIGI',
	'thetallermariobros@gmail.com',
	'1985-B Plumbers Way, Mushroom Kingdom',
	'gold coins'
), (
	'Princess Peach',
	'Toadstool',
	'929-55-PEACH',
	'not-damsel-in-distress-anymore@gmail.com',
	'1985 Mushroom Castle, Mushroom Kingdom',
	'gold coins'
), (
	'Bowser',
	'Koopa',
	'929-55-KOOPA',
	'peaches_peaches_peaches_peaches_peaches_i_LOVE_you@gmail.com',
	'1985 Floating Castle, Bowser Kingdom',
	'gold coins'
);

select *
from customers;


insert into Car (
	price,
	model,
	new_car,
	customer_id
) values (
	200,
	'1992 Red Go-Kart Model M',
	'False',
	1
), (
	200,
	'1992 Green Go-Kart Model Mach 8',
	'False',
	2
), (
	5000,
	'1992 Pink Go-Kart Model Heart Coach',
	'True',
	3
), (
	5000,
	'1992 Yellow Go-Kart Model Koopa Clown',
	'True',
	4
);

select *
from Car;


--stored function for adding to customers table
create or replace function add_customers(
	customer_id INTEGER,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	phone_number VARCHAR(20),
	email_address VARCHAR(100),
	address VARCHAR(50),
	payment VARCHAR(50)
)
returns void
as $main$
begin 
	insert into customers
	values(customer_id, first_name, last_name, phone_number, email_address, address, payment);
end;
$main$
language plpgsql;

select add_customers(5, 'Toad', 'Kinopio', '929-55-TOAD1', 'theOGToad@gmail.com', '1985 Mushroom City, Mushroom Kingom', 'gold coins');

select *
from customers;


-- stored function for adding to mechanics table
create or replace function add_mechanics(
	mec_id INTEGER,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	phone_number VARCHAR(20)
)
returns void
as $main$
begin 
	insert into mechanics
	values(mec_id, first_name, last_name, phone_number);
end;
$main$
language plpgsql;

select add_mechanics(1, 'Smooth', 'Shades', '929-55-KONG1');
select add_mechanics(2, 'Mohawk', 'Shades', '929-55-KONG2');
select add_mechanics(3, 'Di', 'Kong', '929-55-KONG3');
select add_mechanics(4, 'Did', 'Kong', '929-55-KONG4');

select *
from mechanics;


-- stored function to add a staff to salesstaff table
create or replace function add_salesstaff(
	salesstaff_id INTEGER,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	phone_number VARCHAR(20),
	email_address VARCHAR(20)
)
returns void
as $main$
begin 
	insert into salesstaff
	values(salesstaff_id, first_name, last_name, phone_number, email_address);
end;
$main$
language plpgsql;

select add_salesstaff(1, 'Chanterelle', 'Toad', '929-001-TOAD', 'toad1@gmail.com');
select add_salesstaff(2, 'Red', 'Toad', '929-002-TOAD', 'toad2@gmail.com');
select add_salesstaff(3, 'Blue', 'Toad', '929-003-TOAD', 'toad3@gmail.com');
select add_salesstaff(4, 'Yellow', 'Toad', '929-004-TOAD', 'toad4@gmail.com');

select*
from salesstaff;



insert into Service_Ticket (
	service_done,
	service_total,
	service_date,
	mec_id,
	car_id
) values (
	'Removed red shell from bumper.',
	1000,
	'1992-08-27',
	1,
	1
), (
	'Changed flat tire from slipping on banana peel.',
	100,
	'1992-08-27',
	2,
	2
), (
	'Oil change',
	150,
	'1995-01-01',
	4,
	3
), (
	'Installed triple spinning red shell missiles.',
	3000,
	'1992-04-01',
	1,
	4
);

select *
from service_ticket;


-- updated service_ticket_id 3 -- changed oil change to star power!
update service_ticket 
set service_done = 'Added star power surround sound system and LED lights.', service_total = 5000, service_date = '1992-09-01'
where mec_id = 4 and car_id = 3;


-- added more new cars
insert into Car (price, model, new_car, customer_id)
values (3000, '1992 Blue Go-Kart Model Toad Kart', 'True', 5);

insert into Car (price, model, new_car, customer_id)
values (10000, '1992 Green Go-Kart Model Koopa King', 'True', 4);

select *
from Car;



insert into Invoice (
	invoice_date,
	salesstaff_id,
	car_id
) values (
	'1992/08/27',
	1,
	3
), (
	'1992/04/01',
	2,
	4
), (
	'1992/08/27',
	3,
	5
), (
	'1992/11/11',
	2,
	4
);

select *
from Invoice;

-- viewing joined info
select *
from customers 
full join car
on customers.customer_id = car.customer_id 
full join invoice 
on car.car_id = invoice.car_id;


--  adding is_serviced column to Car table
alter table car 
add is_serviced BOOLEAN;

select *
from Car;



-- procedure to update is_service column
create or replace procedure UpdateServiceStatus(
    in car_id_param INTEGER
)
language plpgsql
as $$
begin
    -- Check if the car had not previously received service
    if not exists (select 1 from Service_Ticket where car_id = car_id_param) then
        -- Update the "is_serviced" column to true
        update Car set is_serviced = true where car_id = car_id_param;
    end if;
end;
$$;
   
call UpdateServiceStatus(5);
call UpdateServiceStatus(6);
call UpdateServiceStatus(1);

select *
from car 
full join service_ticket 
on car.car_id = service_ticket.car_id;


