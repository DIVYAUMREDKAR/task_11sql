--Part 1 :create 5 function on ecom			
 	
select * from sales
select * from product
select * from customer

--1) age<25 adult, age<45 Middle-age else Old-age

create or replace function age_criteria(age int)
returns varchar as $$
declare
	age_status varchar;
begin
	case
		when age<25 then age_status:='Adult';
		when age<45 then age_status:='Middle-age';
		else age_status:='Old-age';
	end case;
	return age_status;
end;
$$ language plpgsql;
select *, age_criteria(age) from customer


--2) We created checkCategory function which checks the category of the things

select distinct category  from product
select distinct sub_category from product where category='Furniture'	
select distinct sub_category from product where category='Technology'
		
create or replace function checkCategory(sub_cat varchar)
returns varchar as $$
declare
	output varchar;
begin
	if sub_cat in ('Tables','Bookcases','Chairs','Furnishings') then output := 'Furniture_Category';
	elseif sub_cat in ('Machines','Accessories','Phones','Copiers') then output := 'Technology_Category'; 
	else output :='Office Supplies';
	end if;
	return output;
end;
$$language plpgsql;
select checkCategory('Phones')


--3) Discount<5 then output low_quantity else high_quantity

create or replace function quantity_status (quantity int)
returns varchar as $$
declare
	output varchar;
begin
	if quantity<5 then output:='low_quantity';
	else output:='high_quantity';
    end if;
    return output;
end;
$$ language plpgsql;
select *, quantity_status (quantity) from sales


--4) We created Checkregion function which checks/gets the region of customers through customer id

select distinct region from customer

create or replace function checkRegion(CustomerID varchar)
returns varchar as $$
declare  
	output varchar;
    Customer_Region varchar;
begin
	 select region into Customer_Region from customer where customer_id=CustomerID;
	 case
	when Customer_Region  in ('Central') then output:= 'Region_Central';
	when Customer_Region  in ('South') then output:= 'Region_South';
	when Customer_Region  in ('East') then output:= 'Region_East';
	when Customer_Region  in ('West') then output:= 'Region_West'; 
	else output:='Not Known';
	end case;
	return output;
end;
$$ language plpgsql; 
select checkRegion('SN-20710') 


-- 5) Sales<500 low sale else high sale
	
create or replace function checksales (sales double precision)
returns varchar as $$
declare
	output varchar;
begin
	if sales <500 then output:='low sale';
	else output:='high sale' cost;
    end if;
    return output;
end;
$$ language plpgsql;
select *, checksales(sales) from sales
	

--Part 3 :Create select and find function

create Or Replace function checkSales(productId varchar)
Returns varchar as $$
declare
	salesStatus varchar;
	sumOfSales float;
begin
	select sum(sales) into sumOfSales from sales where product_id = productId;
	if sumOfSales > 500 THEN salesStatus := 'sales is good ';
	else salesStatus := 'sales is not good ';
	end if;
	return salesStatus;
end;	
$$ LANGUAGE Plpgsql
	
select sum(sales) , product_id from sales group by product_id

select checksales('OFF-PA-10003656')

select sum(sales) , product_id, checksales(product_id) from sales group by product_id