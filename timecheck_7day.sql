CREATE TEMPORARY TABLE prefix_loginsonly_temp
SELECT 
cast(from_unixtime(prefix_log.time) AS datetime) AS intime, 
prefix_log.userid,
prefix_user.lastname AS inlname,
prefix_user.firstname AS infname,
prefix_log.action,
prefix_user_info_data.data AS location
FROM prefix_log
JOIN prefix_user ON prefix_log.userid=prefix_user.id
JOIN prefix_user_info_data ON prefix_user.id=prefix_user_info_data.userid
WHERE prefix_log.action LIKE "login"
AND prefix_user_info_data.fieldid=7
AND prefix_log.time BETWEEN UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 7 DAY)) AND UNIX_TIMESTAMP(CURDATE())
ORDER BY prefix_user_info_data.data ASC, prefix_user.lastname ASC, prefix_log.time ASC;
CREATE TEMPORARY TABLE prefix_logoutsonly_temp
SELECT
cast(from_unixtime(prefix_log.time) AS datetime) AS outtime, 
prefix_log.userid,
prefix_user.lastname AS outname,
prefix_user.firstname,
prefix_log.action,
prefix_user_info_data.data
FROM prefix_log
JOIN prefix_user ON prefix_log.userid=prefix_user.id
JOIN prefix_user_info_data ON prefix_user.id=prefix_user_info_data.userid
WHERE prefix_log.action LIKE "logout"
AND prefix_user_info_data.fieldid=7
AND prefix_log.time BETWEEN UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 7 DAY)) AND UNIX_TIMESTAMP(CURDATE());
SELECT 
    location,
    inlname,
    infname,
    DATE(intime) AS date,
    TIME(intime) AS timecheckin,
    TIME(outtime) AS timecheckout
FROM
    prefix_loginsonly_temp
        JOIN
    prefix_logoutsonly_temp ON prefix_loginsonly_temp.userid = prefix_logoutsonly_temp.userid
WHERE
    DATE(intime) = DATE(outtime)
        AND TIMESTAMPDIFF(MINUTE, intime, outtime) BETWEEN 1 AND 5;
DROP TEMPORARY TABLE prefix_loginsonly_temp, prefix_logoutsonly_temp;
