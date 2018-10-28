Students List - Inactive

 A complete list of all student accounts that have been &quot;deleted&quot; from active use. Note that the list includes those who did not have an employee number for them entered into the system. 

 SELECT Last, First, EmployeeNumber FROM (SELECT id AS "ident", lastname AS "Last", firstname AS "First"
 
 FROM prefix_user WHERE deleted = '1') AS result1

 LEFT JOIN (SELECT userid, fieldid, data AS "EmployeeNumber" 
 
 FROM prefix_user_info_data 
 
 WHERE prefix_user_info_data.fieldid = '6') AS result2 

 ON result1.ident = result2.userid
