-- Pending All Enrollees (Annual Category Courses 2011) v1

-- This report lists all enrollees in annual re-certification courses for veteran employees, which must be completed within 1 year of an individuals last certification.<br /> 

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
      and prefix_course.idnumber in ('5004','5005','5006')
