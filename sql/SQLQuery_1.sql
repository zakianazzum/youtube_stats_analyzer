/*
 1. Define the Variables
 2. Create a CTE that rounds the average views per video
 3. Select the columns that are required for the analysis
 4. Filter the results by the youTube channels with the highest subscriber bases
 5. Order by net profit (From highest to lowest)
*/

-- 1.
DECLARE @conversionRate FLOAT = 0.02;       -- The conversion rate is 2%
DECLARE @productCost MONEY = 5.0;           -- The product cost is $5
DECLARE @campaignCost MONEY = 50000.0;      -- The campaign cost is $50000

-- 2.
WITH ChannelData AS (
    SELECT 
        channel_name,
        TotalVideos,
        TotalViews,
        ROUND ((CAST(TotalViews AS FLOAT) / TotalVideos), -4 ) AS rounded_avg_views_per_video


    FROM 
        youTube_db.dbo.view_channel_statistics

)


-- 3. 
SELECT 
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost - @campaignCost) AS net_profit
FROM 
    ChannelData

-- 4.    
WHERE
    channel_name IN ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')   
--5
ORDER BY
    net_profit DESC;