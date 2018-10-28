-- In-Service Course Completions
--
-- This report lists all employees who have completed one or more In-Service training courses in the WBRES.
--
-- Due to limitations of this report, each employee name/starting date/hiring date combination is listed for each course completed by the employee. For further processing and reporting, use the 'Download the CSV' link to import the data that is published in the report into a separate spreadsheet.<br />


SELECT firstname AS "Firstname",
       lastname AS "Lastname",
       Hire AS "Hiring Date", 
       Start AS "Starting Date", 
       certificateid AS "Certificate ID", 
       FROM_UNIXTIME(timecreated, '%m/%d/%Y') AS "Completed on", 
       code AS "Validation"
FROM prefix_certificate_issues AS m1 
LEFT JOIN (SELECT *
           FROM (SELECT u2.id AS zid, 
                        u2.firstname, 
                        u2.lastname, 
                        a3.data AS "Start"
                 FROM prefix_user AS u2, 
                      prefix_user_info_field AS a4, 
                      prefix_user_info_data AS a3 
                 WHERE u2.id = a3.userid 
                       AND a3.fieldid = "2"
                       AND a4.id = a3.fieldid
                       AND u2.id) AS j2
           LEFT JOIN (SELECT U1.id AS xid, 
                             A2.data AS "Hire"
                      FROM prefix_user AS U1, 
                           prefix_user_info_field AS A1, 
                           prefix_user_info_data AS A2
                      WHERE U1.id = A2.userid
                            AND A2.fieldid =  "1"
                            AND A1.id = A2.fieldid) AS j1 
           ON j2.zid = j1.xid) as j3 
ON m1.userid = j3.zid
