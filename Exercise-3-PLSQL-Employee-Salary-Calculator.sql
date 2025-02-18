
SET VERIFY OFF
SET SERVEROUTPUT ON 
-- Declaring varable 
DECLARE 

NORMAL_HOURS CONSTANT NUMBER:=40;
employee_hours_worked   NUMBER:=&Hours_worked ;
Hourly_rate  NUMBER(7,2):=&Hourly_rate;
employee_gross_salary NUMBER;
employee_tax_payable  NUMBER;
employee_net_salary NUMBER;

TAX_RATE CONSTANT NUMBER(4,2):=&TaxRate;

additional_hours NUMBER;
additional_hours_rate NUMBER;
regular_hourly_rate NUMBER;
BEGIN 
   --set regulart hours rate
     regular_hourly_rate:=Hourly_rate;
	 
IF employee_hours_worked <=40 THEN 

	 -- Calculate employee_gross_salary
     employee_gross_salary:=(NORMAL_HOURS*regular_hourly_rate);
 
	
ELSIF employee_hours_worked >40 AND employee_hours_worked <=50  THEN 
	--Calculate additional_hours
     additional_hours:=(employee_hours_worked-NORMAL_HOURS);
	 
	 --Calculate  additional_hours_rate
	 additional_hours_rate:=(regular_hourly_rate*1.5);
	
	
	 -- Calculate employee_gross_salary
     employee_gross_salary:=(NORMAL_HOURS*regular_hourly_rate) +(additional_hours*additional_hours_rate);
ELSE 
	--Calculate additional_hours
     additional_hours:=(employee_hours_worked-NORMAL_HOURS);
	 
	 --Calculate  additional_hours_rate
	 additional_hours_rate:=(regular_hourly_rate*2);
	 
	 -- Calculate employee_gross_salary
     employee_gross_salary:=(NORMAL_HOURS*regular_hourly_rate) +(additional_hours*additional_hours_rate);
 
	
END IF;

employee_tax_payable :=employee_gross_salary*(TAX_RATE/100); 
employee_net_salary:=employee_gross_salary-employee_tax_payable;

--Printing Results

DBMS_OUTPUT.PUT_LINE('==================Employyee Salary Summary====================');
DBMS_OUTPUT.PUT_LINE('Tax Rate               :'|| TAX_RATE||'%');
DBMS_OUTPUT.PUT_LINE('Tax Payable Tax        :R'|| TRIM(To_Char(employee_tax_payable,'999,99999.99')));
DBMS_OUTPUT.PUT_LINE('Employee Hours Worked  :'||employee_hours_worked || ' hours');
DBMS_OUTPUT.PUT_LINE('Employee Gross Salary  :R'||TRIM(To_Char(employee_gross_salary,'999,99999.99')));
DBMS_OUTPUT.PUT_LINE('Employee Net Salary    :R'||TRIM(To_Char(employee_net_salary,'999,99999.99')));

DBMS_OUTPUT.PUT_LINE('==================End====================');
END;
/
