In-Service Completions with Locations

Similar to the report &quot;In Service Course Completions&quot;, this report also included the assignment locations for each employee. 

SELECT studentname AS "Student",

       hire AS "Hiring Date",

              start AS "Starting Date",

                     loc AS "Location",

                            classname AS "Course",

                                   FROM_UNIXTIME(certdate, '%m/%d/%Y') AS "Completed on", 

                                          reportgrade AS "Score", 

                                                 code AS "Validation"       

                                                 FROM prefix_certificate_issues

                                                 LEFT JOIN

                                                     (SELECT p2.inforecord,
                                                     
                                                            p2.person,
                                                            
                                                                   p2.loc,
                                                                   
                                                                          p2.hire,
                                                                          
                                                                                 prefix_user_info_data.data AS start
                                                                                 
                                                                                      FROM
                                                                                      
                                                                                              (SELECT p1.id AS inforecord,
                                                                                              
                                                                                                              p1.userid AS person, 
                                                                                                              
                                                                                                                              p1.data AS loc,
                                                                                                                              
                                                                                                                                              prefix_user_info_data.data AS hire
                                                                                                                                              
                                                                                                                                                       FROM prefix_user_info_data AS p1
                                                                                                                                                       
                                                                                                                                                                LEFT JOIN prefix_user_info_data 
                                                                                                                                                                
                                                                                                                                                                         ON (p1.userid = prefix_user_info_data.userid AND prefix_user_info_data.fieldid = "1")
                                                                                                                                                                         
                                                                                                                                                                                  WHERE p1.fieldid = "7") AS p2
                                                                                                                                                                                  
                                                                                                                                                                                       LEFT JOIN prefix_user_info_data
                                                                                                                                                                                       
                                                                                                                                                                                            ON (p2.person = prefix_user_info_data.userid AND prefix_user_info_data.fieldid = "2")) as p3

                                                                                                                                                                                            ON p3.person = prefix_certificate_issues.userid
