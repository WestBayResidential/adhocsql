Quiz Attempts

 This listing shows all of the test attempts by each student, ordered by Test and Employee/Student name. 

 SELECT quiz, `prefix_quiz`.name, `prefix_user`.lastname,`prefix_user`.firstname, attempt, `prefix_quiz_attempts`.sumgrades FROM `prefix_quiz_attempts`

 LEFT JOIN `prefix_quiz` ON `prefix_quiz_attempts`.quiz = `prefix_quiz`.id

 LEFT JOIN `prefix_user` ON `prefix_quiz_attempts`.userid = `prefix_user`.id

 ORDER BY quiz, `prefix_user`.lastname, attempt
