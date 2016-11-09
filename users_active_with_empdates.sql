SELECT ident, idnumber, Last, First, Employee_Number, User_Name, eMail, Location, Hire_Date, Start_Date 
FROM 
  (SELECT * 
   FROM
     (SELECT id AS "ident", 
             idnumber AS "idnumber",
             lastname AS "Last", 
             firstname AS "First", 
             username AS "User_Name", 
             password AS "password",
             email AS "eMail" 
      FROM mdl_user 
      WHERE deleted = '0') AS result1
   LEFT JOIN 
     (SELECT userid, 
             fieldid, 
             data AS "Employee_Number" 
      FROM mdl_user_info_data 
      WHERE mdl_user_info_data.fieldid = '6') AS result2 
   ON result1.ident = result2.userid) AS result3
   LEFT JOIN
     (SELECT * 
      FROM
        (SELECT * 
         FROM 
           (SELECT u2.id AS zid, 
                   u2.firstname, 
                   u2.lastname, 
                   a3.data AS "Start_Date" 
            FROM mdl_user AS u2, 
                 mdl_user_info_field AS a4, 
                 mdl_user_info_data AS a3 
            WHERE u2.id = a3.userid 
            AND a3.fieldid = "2" 
            AND a4.id = a3.fieldid 
            AND u2.id) AS j2
      LEFT JOIN 
        (SELECT U1.id AS xid, 
                A2.data AS "Hire_Date" 
         FROM mdl_user AS U1, 
              mdl_user_info_field AS A1, 
              mdl_user_info_data AS A2 
         WHERE U1.id = A2.userid 
         AND A2.fieldid =  "1" 
         AND A1.id = A2.fieldid) AS j1 
      ON j2.zid = j1.xid) AS j3
      LEFT JOIN
        (SELECT U3.id AS wid, 
                A6.data AS "Location" 
         FROM mdl_user AS U3, 
              mdl_user_info_data AS A6 
         WHERE U3.id = A6.userid 
         AND A6.fieldid =  "7") AS j4
      ON j3.zid = j4.wid) AS j5
ON result3.ident = j5.wid
ORDER BY ident 
