-- Set the context to the 'weightrax' database
USE weightrax;

DECLARE @7daysago DATETIME = DATEADD(DAY, -7, GETDATE())
DECLARE @30daysago DATETIME = DATEADD(Day, -30, GETDATE())

-- Check if the 'RawApiLog' table exists
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'RawApiLog')
BEGIN    
    DECLARE @recs INT = 0
	SELECT @recs = COUNT(*) FROM RawApiLog
    WHERE Received < @7daysago
 
    PRINT 'RawApiLog has ' + CONVERT(NVARCHAR, @recs) + ' records older than ' + CONVERT(NVARCHAR, @7daysago, 102)
    IF @recs > 0
    BEGIN
        PRINT 'Deleting these records...'
        DELETE FROM RawApiLog WHERE Received < @7daysago
    END
END
ELSE
BEGIN
    PRINT 'RawApiLog table does not exist.'
END

 

-- Check if the 'visit_image' table exists
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'visit_image')
BEGIN
    DECLARE @images INT = 0
	SELECT @images = COUNT(*) FROM visit_image
    WHERE image_dt < @7daysago
 
    PRINT 'visit_image has ' + CONVERT(NVARCHAR, @images) + ' images older than ' + CONVERT(NVARCHAR, @7daysago, 102)
    IF @images > 0
    BEGIN
        PRINT 'Deleting these images...'
        DELETE FROM visit_image WHERE image_dt < @7daysago
    END
END
ELSE
BEGIN
    PRINT 'visit_image table does not exist.'
END
-- Shrinking database
PRINT 'Shrinking database...'
DBCC SHRINKDATABASE(weightrax, 10)
PRINT 'Database shrink operation completed.'