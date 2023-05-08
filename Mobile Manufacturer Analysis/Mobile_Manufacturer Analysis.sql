use db_SQLCaseStudies;

Select Top 5 * from DIM_CUSTOMER;
Select Top 5 * from FACT_TRANSACTIONS;
Select Top 5 * from DIM_DATE;
Select Top 5 * from DIM_LOCATION;
Select * from DIM_MANUFACTURER;
Select Top 20 * from DIM_MODEL;


--Q1- 
    Select [State], count(IdCustomer) From DIM_LOCATION L inner Join FACT_TRANSACTIONS F
	on L.IDLocation =F.IDLocation
	Where Year(Date) > 2005
	group by [State];
	--End
--Q2 -
     Select TOP 1 [State], Count(IdCustomer) from DIM_LOCATION L inner join FACT_TRANSACTIONS F on L.IDLocation = F.IDLocation inner Join DIM_MODEL D on F.IDModel = D.IDModel 
	 inner join DIM_MANUFACTURER M on D.IDManufacturer = M.IDManufacturer
	 Where Country = 'US' AND Manufacturer_Name = 'Samsung'
      Group by State
	  Order by Count(IdCustomer) Desc;
	  --END

--Q3 - 
      Select IdModel, Zipcode, State,Count(IdCustomer) as No_of_transactions
	  From DIM_LOCATION L Right Join FACT_TRANSACTIONS F on L.IDLocation = F.IDLocation 
	  Group by IDModel, ZipCode, State
	  Order by IdModel,Zipcode, State; 
	  --END

--Q4 - 
        Select Top 1 Model_Name, Unit_Price From DIM_MODEL
		Order by Unit_price;
		--END

--Q5 - 
       Select Manufacturer_Name, Model_Name, Sum(TotalPrice)/Sum(Quantity) as AvgPrice
	   From FACT_TRANSACTIONS F inner Join DIM_MODEL D on F.IDModel = D.IDModel inner Join DIM_MANUFACTURER M on D.IDManufacturer = M.IDManufacturer
	   Where Manufacturer_Name in (Select Top 5 Manufacturer_Name From FACT_TRANSACTIONS F inner join DIM_MODEL D on F.IDModel = D.IDModel inner join
	   DIM_MANUFACTURER M on D.IDManufacturer = M.IDManufacturer  Group by Manufacturer_Name
	   Order by Sum(Quantity) Desc)
	   group by Manufacturer_Name, Model_Name
	   Order by Manufacturer_Name, AvgPrice;
	   --END

--Q6 - 

       Select Customer_Name, Avg(TotalPrice)
	   From DIM_CUSTOMER C inner Join (Select * from FACT_TRANSACTIONS Where Year(Date) = '2009') as F on C.IDCustomer = F.IDCustomer
	  Group by Customer_Name
	  Having Avg(TotalPrice)>500;

------------------------------------------
	  Select Customer_Name, Avg(TotalPrice)
	   From DIM_CUSTOMER C inner Join FACT_TRANSACTIONS as F on C.IDCustomer = F.IDCustomer
	   Where Year(Date) = '2009'
	  Group by Customer_Name
	  Having Avg(TotalPrice)>500;

	--END

--Q7 -
Select * From
    (Select Top 5 IdModel From
	 FACT_TRANSACTIONS 
	 Where year(date) = '2008'
	 Group by IDModel
	 Order by Sum(Quantity) Desc
	 Intersect
	Select Top 5 IdModel From
	 FACT_TRANSACTIONS 
	 Where year(date) = '2009'
	 Group by IDModel
	 Order by Sum(Quantity) Desc
	 Intersect
	 (Select Top 5 IdModel From
	 FACT_TRANSACTIONS 
	 Where year(date) = '2010'
	 Group by IDModel
	 Order by Sum(Quantity) Desc)) as T3;
	 --END

--Q8 - 
   Select * From (  Select Top 1  Manufacturer_Name, Year(Date) as [Year],  Sum(TotalPrice) as TotalSales
	 From (Select Top 2 Manufacturer_Name, Date,  Sum(TotalPrice) as TotalPrice From FACT_TRANSACTIONS F inner Join DIM_MODEL D on F.IDModel = D.IDModel inner join
	 DIM_MANUFACTURER M on D.IDManufacturer = M.IDManufacturer
	  Where Year(date) = '2009'
	 Group by Manufacturer_Name, Date
	
	 Order by Sum(TotalPrice) Desc) as a
	 Group by Manufacturer_Name, Date
	 Order by Sum(TotalPrice) 
	 Union
	     Select Top 1  Manufacturer_Name, Year(Date) as [Year],  Sum(TotalPrice) as TotalSales
	 From (Select Top 2 Manufacturer_Name, Date,  Sum(TotalPrice) as TotalPrice From FACT_TRANSACTIONS F inner Join DIM_MODEL D on F.IDModel = D.IDModel inner join
	 DIM_MANUFACTURER M on D.IDManufacturer = M.IDManufacturer
	  Where Year(date) = '2010'
	 Group by Manufacturer_Name, Date
	
	 Order by Sum(TotalPrice) Desc) as a
	 Group by Manufacturer_Name, Date
	 Order by Sum(TotalPrice)) as T1 ;
	 --END

--Q9-
     Select Manufacturer_Name
	 From FACT_TRANSACTIONS F Inner Join DIM_MODEL D on F.IDModel = D.IDModel inner Join DIM_MANUFACTURER M on D.IDManufacturer = M.IDManufacturer
	 Where Year(Date) = 2010
	 Except
	 Select Manufacturer_Name
	 From FACT_TRANSACTIONS F Inner Join DIM_MODEL D on F.IDModel = D.IDModel inner Join DIM_MANUFACTURER M on D.IDManufacturer = M.IDManufacturer
	 Where Year(Date) = 2009;
	 --END







 
































