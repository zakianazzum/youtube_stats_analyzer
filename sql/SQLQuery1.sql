-- Data cleaning 
-- Extracting the channel name from the Name column 

CREATE VIEW 
	view_channel_statistics as

SELECT 
	CAST(SUBSTRING(Name, 1, CHARINDEX ('@', Name) -1 ) AS VARCHAR(100)) AS channel_name,
	Subscribers,
	TotalVideos,
	TotalViews
FROM
	 channel_statistics;


-- Data Quality check 
-- counting data

SELECT 
	COUNT(*) AS no_of_rows
FROM 
	view_channel_statistics;

-- Collumn Count
SELECT 
	COUNT(*) AS column_count
FROM
	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'view_channel_statistics'

-- Data type check
SELECT 
	COLUMN_NAME,
	DATA_TYPE
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'view_channel_statistics';

-- Duplicate record check

SELECT
	channel_name,
	COUNT(*) as duplicate_count
FROM 
	view_channel_statistics
GROUP BY
	channel_name
HAVING
	COUNT(*) > 1

