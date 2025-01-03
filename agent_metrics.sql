WITH agent_metrics AS (
    -- Individual agent metrics
    SELECT 
        county_lookup.ï»¿county_name,
        agent_lookup.agent_name,
        SUM(biochar_sales.biochar_bags) as total_bags,
        SUM(biochar_sales.order_amount_total) as total_expected,
        SUM(biochar_sales.paid_today) as total_received,
        SUM(biochar_sales.order_amount_total - biochar_sales.paid_today) as remaining_balance
    FROM biochar_sales 
    JOIN agent_lookup ON biochar_sales.agent_id = agent_lookup.ï»¿agent_id
    JOIN county_lookup ON county_lookup.county_id = agent_lookup.county_id
    GROUP BY county_lookup.ï»¿county_name, agent_lookup.agent_name

    UNION ALL
    
    -- County Subtotals
    SELECT 
        county_lookup.ï»¿county_name,
        'County Total' as agent_name,
        SUM(biochar_sales.biochar_bags) as total_bags,
        SUM(biochar_sales.order_amount_total) as total_expected,
        SUM(biochar_sales.paid_today) as total_received,
        SUM(biochar_sales.order_amount_total - biochar_sales.paid_today) as remaining_balance
    FROM biochar_sales 
    JOIN agent_lookup ON biochar_sales.agent_id = agent_lookup.ï»¿agent_id
    JOIN county_lookup ON county_lookup.county_id = agent_lookup.county_id
    GROUP BY county_lookup.ï»¿county_name

    UNION ALL
    
    -- Grand Total
    SELECT 
        'Grand Total' as ï»¿county_name,
        'All Counties' as agent_name,
        SUM(biochar_sales.biochar_bags) as total_bags,
        SUM(biochar_sales.order_amount_total) as total_expected,
        SUM(biochar_sales.paid_today) as total_received,
        SUM(biochar_sales.order_amount_total - biochar_sales.paid_today) as remaining_balance
    FROM biochar_sales
)
SELECT 
    ï»¿county_name,
    agent_name,
    total_bags,
    total_expected,
    total_received,
    remaining_balance
FROM agent_metrics
ORDER BY 
    CASE WHEN ï»¿county_name = 'Grand Total' THEN 2
         WHEN agent_name = 'County Total' THEN 1
         ELSE 0 END,
    ï»¿county_name,
    total_bags DESC;