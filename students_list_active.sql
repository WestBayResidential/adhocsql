-- Students List - Active

-- This report lists all student accounts and email addresses. sorted by last name/first name. The list includes those who do not have an employee number entered into their profile.<br />

SELECT Last, 
       First, 
       EmployeeNumber 
FROM (SELECT id AS "ident", 
             lastname AS "Last", 
             firstname AS "First"
      FROM prefix_user 
      WHERE deleted = '0') AS result1
LEFT JOIN (SELECT userid, 
                  fieldid, 
                  data AS "EmployeeNumber" 
           FROM prefix_user_info_data 
           WHERE prefix_user_info_data.fieldid = '6') AS result2 
ON result1.ident = result2.userid
