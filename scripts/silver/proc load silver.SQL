
/*
===============================================================================
SILVER LAYER: Clean and transform data from Bronze
===============================================================================
*/


truncate table silver.crm_cust_info;
insert into silver.crm_cust_info (
	cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date
)

select 
	cst_id,
    cst_key,
    trim(cst_firstname) as cst_firstname,
    trim(cst_lastname) as cst_lastname,
    case
		when upper(trim(cst_marital_status)) = 'M' then 'Married'
        when upper(trim(cst_marital_status)) = 'S' then 'Single'
        else 'N/A'
	end cst_marital_status,
    case upper(trim(cst_gndr))
		when 'F' then 'Female'
        when 'M' then 'Male' 
        else 'N/A'
	end cst_gndr, 
    cst_create_date
from
	(select *,
		row_number() over(partition by cst_id order by cst_create_date desc) as rank_
	from bronze.crm_cust_info) as t 
where rank_ = 1;


truncate table silver.crm_prd_info;
insert into silver.crm_prd_info(
		prd_id,
        category_id,
        prd_key,
        prd_nm,
        prd_cost,
        prd_line,
        prd_start_dt,
        prd_end_dt
)

select prd_id,
       replace(substring(prd_key, 1, 5), '-', '_') as category_id,
       substring(prd_key, 7, length(prd_key)) as prd_key,
       prd_nm,
       ifnull(prd_cost, 0) as prd_cost,
       case upper(prd_line)
	       when 'M' then 'Montain'
           when 'R' then 'Road'
           when 'S' then 'Other Sales'
           when 'T' then 'Touring'
		   else 'N/A' 
		end as prd_line,
       prd_start_dt,
       lead(prd_start_dt) over(partition by prd_key order by prd_start_dt asc) - interval 1 day as prd_end_dt
from bronze.crm_prd_info;

truncate table silver.crm_sales_details;
insert into silver.crm_sales_details(
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)

select
	sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    case
		when sls_order_dt <= 0 
        or length(sls_order_dt) != 8 
        then 'N/A'
        else cast(sls_order_dt as date)
	end sls_order_dt,
    case
		when sls_ship_dt <= 0
        or length(sls_ship_dt) != 8
        then 'N/A'
        else cast(sls_ship_dt as date)
	end sls_ship_dt,
    case
		when sls_due_dt <= 0
        or length(sls_due_dt) != 8
        then 'N/A'
        else cast(sls_due_dt as date)
	end sls_due_dt,
    case
		when sls_sales is null
        or sls_sales <= 0
        or sls_sales != sls_quantity * abs(sls_price)
        then sls_quantity * abs(sls_price)
        else sls_sales
	end sls_sales,
    sls_quantity,
	case
		when sls_price is null or sls_price <= 0
		then (
			case
				when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity * abs(sls_price)
				then sls_quantity * ABS(sls_price)
				else sls_sales
			end
		) / NULLIF(sls_quantity, 0)
		else sls_price
	end as sls_price
from bronze.crm_sales_details;

truncate table silver.erp_cust_az12;
insert into silver.erp_cust_az12(
	cid,
    bdate,
    gen
)

select
	case
		when cid like 'NAS%' then substring(cid, 4, length(cid))
        else cid
	end cid,
    case
		when bdate > now() then null
        when bdate < '1957-01-01' then null
		else bdate
	end bdate,
	case
		when UPPER(TRIM(gen)) like 'M%' then 'Male'
		when UPPER(TRIM(gen)) like 'F%' then 'Female'
		else null
	end gen
from bronze.erp_cust_az12;

truncate table silver.erp_loc_a101;
insert into silver.erp_loc_a101(
	cid,
    cntry
)

select
	replace(cid,'-','') as cid,
    case
		when upper(trim(cntry)) like 'US%' or trim(cntry) like '%USA%' then 'United States'
        when upper(trim(cntry)) like 'DE%'  then 'germany'
        when trim(cntry) = '' then null
        else trim(cntry)
	end cntry
from bronze.erp_loc_a101;

truncate table silver.erp_px_cat_g1v2;
insert into silver.erp_px_cat_g1v2(
	id,
    cat,
    subcat,
    maintenance
)

select
	id,
    cat,
    subcat,
    maintenance
from bronze.erp_px_cat_g1v2 
