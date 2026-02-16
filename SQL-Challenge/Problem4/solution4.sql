SELECT 
    product_id,
    dates,
    weekday_no,
    SUBSTRING(day_indicator, weekday_no, 1) AS is_available
FROM (
    SELECT 
        product_id,
        dates,
        day_indicator,
        ((DAYOFWEEK(dates) + 5) % 7) + 1 AS weekday_no
    FROM day_indicator
) t;
