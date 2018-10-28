Pending Near Deadline (30 Day Category Courses) v1

List of enrollees in courses that must be completed within 30 days of hire date, and who are within 15 days or less of the deadline (including past deadline). 

select prefix_user.lastname as Lastname,
       prefix_user.firstname as Firstname,
       prefix_user.email as Email,
       prefix_course.shortname as Course,
       FROM_UNIXTIME(prefix_role_assignments.timemodified, '%m-%d-%Y') as 'Enrolled Date'
from prefix_user,
     prefix_context,
     prefix_role_assignments,
     prefix_course
where prefix_user.id=prefix_role_assignments.userid
and prefix_role_assignments.roleid=5
and prefix_role_assignments.contextid=prefix_context.id
and prefix_context.contextlevel=50
and prefix_context.instanceid=prefix_course.id
and prefix_course.idnumber in ('2001','2002','2003','2004','2005','2006')
and DATEDIFF(CURDATE(),FROM_UNIXTIME(prefix_role_assignments.timemodified,'%Y-%m-%d'))>=15
