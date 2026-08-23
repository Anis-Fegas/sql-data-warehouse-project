
/*
===============================================================================
DATA QUALITY CHECKS
Purpose: Validate data integrity across Bronze and Silver layers
===============================================================================
*/

-- ============================================
-- 1. DUPLICATE CHECKS
-- ============================================

-- crm_cust_info
SELECT 
    'crm_cust_info' AS table_name,
    cst_id,
    COUNT(*) AS duplicate_count
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

-- crm_prd_info
SELECT 
    'crm_prd_info' AS table_name,
    prd_id,
    COUNT(*) AS duplicate_count
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1;

-- crm_sales_details
SELECT 
    'crm_sales_details' AS table_name,
    sls_ord_num,
    COUNT(*) AS duplicate_count
FROM bronze.crm_sales_details
GROUP BY sls_ord_num
HAVING COUNT(*) > 1;

-- ============================================
-- 2. NULL CHECKS (Bronze)
-- ============================================

SELECT 'bronze.crm_cust_info' AS table_name,
       SUM(CASE WHEN cst_id IS NULL THEN 1 ELSE 0 END) AS null_cst_id,
       SUM(CASE WHEN cst_key IS NULL THEN 1 ELSE 0 END) AS null_cst_key
FROM bronze.crm_cust_info;

SELECT 'bronze.crm_prd_info' AS table_name,
       SUM(CASE WHEN prd_id IS NULL THEN 1 ELSE 0 END) AS null_prd_id,
       SUM(CASE WHEN prd_key IS NULL THEN 1 ELSE 0 END) AS null_prd_key
FROM bronze.crm_prd_info;

SELECT 'bronze.erp_cust_az12' AS table_name,
       SUM(CASE WHEN cid IS NULL THEN 1 ELSE 0 END) AS null_cid
FROM bronze.erp_cust_az12;

-- ============================================
-- 3. ROW COUNT COMPARISON (Bronze vs Silver)
-- ============================================

SELECT 'crm_cust_info' AS table_name,
       (SELECT COUNT(*) FROM bronze.crm_cust_info) AS bronze_count,
       (SELECT COUNT(*) FROM silver.crm_cust_info) AS silver_count,
       (SELECT COUNT(*) FROM bronze.crm_cust_info) - (SELECT COUNT(*) FROM silver.crm_cust_info) AS difference
UNION ALL
SELECT 'crm_prd_info',
       (SELECT COUNT(*) FROM bronze.crm_prd_info),
       (SELECT COUNT(*) FROM silver.crm_prd_info),
       (SELECT COUNT(*) FROM bronze.crm_prd_info) - (SELECT COUNT(*) FROM silver.crm_prd_info)
UNION ALL
SELECT 'crm_sales_details',
       (SELECT COUNT(*) FROM bronze.crm_sales_details),
       (SELECT COUNT(*) FROM silver.crm_sales_details),
       (SELECT COUNT(*) FROM bronze.crm_sales_details) - (SELECT COUNT(*) FROM silver.crm_sales_details);

-- ============================================
-- 4. INVALID DATE CHECKS (Bronze)
-- ============================================

SELECT 'crm_sales_details' AS table_name,
       COUNT(*) AS invalid_order_dates
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 OR LENGTH(sls_order_dt) != 8;

SELECT 'erp_cust_az12' AS table_name,
       COUNT(*) AS invalid_birthdates
FROM bronze.erp_cust_az12
WHERE bdate > NOW() OR bdate < '1900-01-01' OR bdate = '0000-00-00';

-- ============================================
-- 5. SALES FORMULA CHECK
-- ============================================

SELECT 
    COUNT(*) AS mismatched_sales
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL;

-- ============================================
-- 6. FOREIGN KEY INTEGRITY (Silver)
-- ============================================

-- Orders with missing customers
SELECT 
    COUNT(*) AS orphaned_orders
FROM silver.crm_sales_details s
LEFT JOIN silver.crm_cust_info c
    ON s.sls_cust_id = c.cst_id
WHERE c.cst_id IS NULL;

-- Products with missing category
SELECT 
    COUNT(*) AS missing_category
FROM silver.crm_prd_info p
LEFT JOIN silver.erp_px_cat_g1v2 e
    ON p.category_id = e.id
WHERE e.id IS NULL;
