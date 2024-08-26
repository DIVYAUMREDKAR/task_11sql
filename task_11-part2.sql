select * from order_data

select * from sports

	
----1) total_price >= 24000 Expensive price else normal
	
create or replace function checktotal_price (total_price double precision)
returns varchar as $$
declare
	output varchar;
begin
	if total_price >= 24000 then output:='Expensive';
	else output:='normal_price';
end if;
return output;
end
$$ language plpgsql;
select total_price, checktotal_price(total_price) from order_data

	
---2) age >=23 then its a new sports_clud else old sports_club

create or replace function checksportsperson_age (sportsperson_age int)
returns varchar as $$
declare
	output varchar;
begin
	if sportsperson_age >= 23 then output:='New sports_clud';
	else output:='Old sports_clud';
end if;
return output;
end
$$ language plpgsql;	
select *, checksportsperson_age (sportsperson_age) from sports
