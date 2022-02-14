create table ecommerce.Supplier(
	SUPP_ID int primary key,
    SUPP_NAME varchar(50),
    SUPP_CITY varchar(50),
    SUPP_PHONE varchar(10)
    );
 
 create table ecommerce.Customer(
	CUS__ID int primary key,
    CUS_NAME varchar(50),
    CUS_PHONE varchar(10),
    CUS_CITY varchar(50),
    CUS_GENDER varchar(20)
    );
    
create table ecommerce.Category(
	CAT_ID int primary key,
    CAT_NAME varchar(50)
    );
    
create table ecommerce.Product(
	PRO_ID int primary key,
    PRO_NAME varchar(50),
    PRO_DESC varchar(100),
    CAT_ID int,
    foreign key (CAT_ID) references ecommerce.Category (CAT_ID)
    );
    
create table ecommerce.ProductDetails(
	PROD_ID int primary key,
    PRO_ID int,
    SUPP_ID int,
    PRICE double,
	foreign key (PRO_ID) references ecommerce.Product (PRO_ID),
    foreign key (SUPP_ID) references ecommerce.Supplier (SUPP_ID)
    );

create table ecommerce.Order(
	ORD_ID int primary key,
    ORD_AMOUNT double,
    ORD_DATE date,
    CUS__ID int,
    PROD_ID int,
    foreign key (CUS__ID) references ecommerce.Customer (CUS__ID),
    foreign key (PROD_ID) references ecommerce.ProductDetails (PROD_ID)
    );
    
create table ecommerce.Rating(
	RAT_ID int primary key,
    CUS__ID int,
    SUPP_ID int,
    RAT_RATSTARS int,
    foreign key (CUS__ID) references ecommerce.Customer (CUS__ID),
    foreign key (SUPP_ID) references ecommerce.Supplier (SUPP_ID)
    );
    
insert into ecommerce.Supplier values (1,'Rajesh Retails','Delhi','1234567890');
insert into ecommerce.Supplier values (2,'Appario Ltd.','Mumbai','2589631470');
insert into ecommerce.Supplier values (3,'Knome products','Banglore','9785462315');
insert into ecommerce.Supplier values (4,'Bansal Retails','Kochi','8975463285');
insert into ecommerce.Supplier values (5,'Mittal Ltd.','Lucknow','7898456532');

insert into ecommerce.Customer values (1,'AAKASH','9999999999','DELHI','M');
insert into ecommerce.Customer values (2,'AMAN','9785463215','NOIDA','M');
insert into ecommerce.Customer values (3,'NEHA','9999999999','MUMBAI','F');
insert into ecommerce.Customer values (4,'MEGHA','9994562399','KOLKATA','F');
insert into ecommerce.Customer values (5,'PULKIT','7895999999','LUCKNOW','M');

insert into ecommerce.Category values (1,'BOOKS');
insert into ecommerce.Category values (2,'GAMES');
insert into ecommerce.Category values (3,'GROCERIES');
insert into ecommerce.Category values (4,'ELECTRONICS');
insert into ecommerce.Category values (5,'CLOTHES');

insert into ecommerce.Product values (1,'GTA V','DFJDJFDJFDJFDJFJF',2);
insert into ecommerce.Product values (2,'TSHIRT','DFDFJDFJDKFD',5);
insert into ecommerce.Product values (3,'ROG LAPTOP','DFNTTNTNTERND',4);
insert into ecommerce.Product values (4,'OATS','REURENTBTOTH',3);
insert into ecommerce.Product values (5,'HARRY POTTER','NBEMCTHTJTH',1);

insert into ecommerce.ProductDetails values (1,1,2,1500);
insert into ecommerce.ProductDetails values (2,3,5,30000);
insert into ecommerce.ProductDetails values (3,5,1,3000);
insert into ecommerce.ProductDetails values (4,2,3,2500);
insert into ecommerce.ProductDetails values (5,4,1,1000);

insert into ecommerce.Order values (20,1500,'2021-10-12',3,5);
insert into ecommerce.Order values (25,30500,'2021-09-16',5,2);
insert into ecommerce.Order values (26,2000,'2021-10-05',1,1);
insert into ecommerce.Order values (30,3500,'2021-08-16',4,3);
insert into ecommerce.Order values (50,2000,'2021-10-06',2,1);

insert into ecommerce.Rating values (1,2,2,4);
insert into ecommerce.Rating values (2,3,4,3);
insert into ecommerce.Rating values (3,5,1,5);
insert into ecommerce.Rating values (4,1,3,2);
insert into ecommerce.Rating values (5,4,5,4);

select COUNT(CUS_NAME),CUS_GENDER from ecommerce.Customer,ecommerce.Order where ecommerce.Customer.CUS__ID = ecommerce.Order.CUS__ID and ecommerce.Order.ORD_AMOUNT>=3000 group by CUS_GENDER;

select ORD_ID,PRO_NAME from ecommerce.Order,ecommerce.Product,ecommerce.ProductDetails where ecommerce.Order.CUS__ID = 2 and ecommerce.Order.PROD_ID = ecommerce.ProductDetails.PROD_ID and ecommerce.ProductDetails.PRO_ID = ecommerce.Product.PRO_ID;

select * from ecommerce.Supplier,ecommerce.ProductDetails where ecommerce.ProductDetails.SUPP_ID = ecommerce.Supplier.SUPP_ID group by ecommerce.ProductDetails.SUPP_ID having COUNT(ecommerce.ProductDetails.SUPP_ID)>1;

select CAT_NAME from ecommerce.Category,ecommerce.Order,ecommerce.ProductDetails,ecommerce.Product where ecommerce.Order.ORD_AMOUNT = ( select min(ORD_AMOUNT) from ecommerce.Order) and ecommerce.Order.PROD_ID = ecommerce.ProductDetails.PROD_ID and ecommerce.ProductDetails.PRO_ID = ecommerce.Product.PRO_ID and ecommerce.Product.CAT_ID = ecommerce.Category.CAT_ID;

select ecommerce.Product.PRO_ID,PRO_NAME from ecommerce.Product,ecommerce.Order,ecommerce.ProductDetails where ecommerce.Order.ORD_DATE > '2021-10-05' and ecommerce.Order.PROD_ID = ecommerce.ProductDetails.PROD_ID and ecommerce.ProductDetails.PRO_ID = ecommerce.Product.PRO_ID;

select CUS_NAME,CUS_GENDER from ecommerce.Customer where ecommerce.Customer.CUS_NAME like 'A%' or ecommerce.Customer.CUS_NAME like '%A';