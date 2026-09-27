
/* ==============================================================
   File: ddl_gold.sql
   Description: DDL script to create the Gold Layer views for the 
                data warehouse (dim_customers, dim_products, fact_sales).
   ============================================================== */

-- ==========================================
-- 1. Create View: gold.dim_customers
-- ==========================================
DROP VIEW IF EXISTS gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS customer_key,
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
    la.cntry AS country,
    CASE
        WHEN ci.cst_gndr != 'N/A' THEN ci.cst_gndr
        ELSE COALESCE(ca.gen, 'N/A')
    END AS gender,
    ca.bdate AS birthdate,
    ci.cst_marital_status AS marital_status,
    ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
    ON ci.cst_key = la.cid;
GO


-- ==========================================
-- 2. Create View: gold.dim_products
-- ==========================================
DROP VIEW IF EXISTS gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER(ORDER BY pi.prd_start_dt, pi.prd_key) AS product_key,
    pi.prd_id AS product_id,
    pi.prd_key AS product_number,
    pi.prd_nm AS product_name,
    pi.prd_cost AS product_cost,
    pi.prd_line AS product_line,
    pi.category_id,
    pc.cat AS category,
    pc.subcat AS sub_category,
    pc.maintenance,
    pi.prd_start_dt AS start_date,
    pi.prd_end_dt AS end_date
FROM silver.crm_prd_info pi
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pi.category_id = pc.id
WHERE pi.prd_end_dt IS NULL;
GO


-- ==========================================
-- 3. Create View: gold.fact_sales
-- ==========================================
DROP VIEW IF EXISTS gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num AS order_number,
    dp.product_key,
    dc.customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt AS ship_date,
    sd.sls_due_dt AS due_date,
    sd.sls_sales AS sales,
    sd.sls_quantity AS quantity,
    sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products dp
    ON sd.sls_prd_key = dp.product_number
LEFT JOIN gold.dim_customers dc
    ON sd.sls_cust_id = dc.customer_id;
GO
