with cte as ( SELECT *,
  
CASE
	WHEN days_for_completion IS NULL THEN NULL
        WHEN days_for_completion = 0 THEN 'Same day'
        WHEN days_for_completion between 1 and 7 THEN '1 to 7 days'
        WHEN days_for_completion between 8 and 30 THEN '8 to 30 days'
        WHEN days_for_completion between 31 and 60 THEN '31 to 60 days'
        WHEN days_for_completion between 61 and 90 THEN '61 to 90career_track_info days'
        WHEN days_for_completion between 91 and 365 THEN '91 to 365 days'
        else '366+ days' end completion_bucket
FROM
   (SELECT row_number() over (order by student_id,i.track_id) student_track_id, student_id, track_name, date_enrolled, case when date_completed is null then 0 else 1 end track_completed,
datediff(date_completed,date_enrolled) days_for_completion
FROM
    career_track_student_enrollments e
        JOIN
    career_track_info i ON e.track_id = i.track_id)a)
    
    
    
 select count(*)
 from cte
 where track_completed = 1