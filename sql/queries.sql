SET search_path TO fitzone;

--First name and last name of instructors who have held Pilates courses in Studio A
SELECT DISTINCT U.firstname, U.lastname
FROM Users U JOIN Instructors I ON U.iduser = I.idinstructor
     JOIN Courses C ON I.idinstructor = C.idinstructor
     JOIN Course_Types CT ON C.idcoursetype = CT.idcoursetype
     JOIN Rooms R ON C.idroom = R.idroom
WHERE CT.name = 'Pilates' and R.name = 'Studio A';

--Titles of CrossFit courses attended by at least one athlete, considering lessons between 9:00 AM and 12:00 PM, ordered by descending attendance count.
SELECT DISTINCT C.title, COUNT(*)
FROM Courses C JOIN Course_Types CT ON C.idcoursetype = CT.idcoursetype
     JOIN Lessons L ON C.idcourse = L.idcourse
     JOIN Attendance A ON L.idlesson = A.idlesson 
     JOIN Athletes AH ON AH.idathlete = A.idathlete
WHERE L.TIME BETWEEN TIME '09:00:00' AND TIME '12:00:00'
GROUP BY C.title
HAVING COUNT(*) >= 1
ORDER BY COUNT(*) DESC;

--IDs of athletes who have memberships including at least one course with the word "Elite" in the title
SELECT DISTINCT A.idathlete
FROM Athletes A JOIN Memberships M ON A.idathlete = M.idathlete
     JOIN Membership_Courses MC ON M.idmembership = MC.idmembership
     JOIN Courses C ON MC.idcourse = C.idcourse
WHERE C.title LIKE '%Elite%';

--IDs of athletes who have memberships including at least one course with the word "Elite" in the title (using EXISTS)
SELECT A.idathlete
FROM Athletes A 
WHERE EXISTS(SELECT * 
             FROM  Memberships M JOIN Membership_Courses MC ON M.idmembership = MC.idmembership
             JOIN Courses C ON MC.idcourse = C.idcourse
             WHERE A.idathlete = M.idathlete and C.title LIKE '%Elite%'
);

--Titles of courses held in the Outdoor Box attended exclusively by athletes who have always rated the lessons with a 5.
SELECT C.title
FROM Courses C JOIN Rooms R ON C.idroom = R.idroom
WHERE R.name = 'Outdoor Box' and 
      NOT EXISTS (SELECT *
                  FROM Lessons L
                  WHERE L.idcourse = C.idcourse and EXISTS (SELECT *
                                                            FROM Attendance A
                                                            WHERE A.idlesson = L.idlesson and A.rating != 5));

--Considering only ratings made by athletes with more than 1 follower, first name and last name of instructors whose average lesson rating is higher than the overall average rating of all lessons held in 2025.
SELECT U.firstname, U.lastname
FROM Users U JOIN Instructors I ON U.iduser = I.idinstructor
     JOIN Courses C ON I.idinstructor = C.idinstructor
     JOIN Lessons L ON C.idcourse = L.idcourse
     JOIN Attendance A ON L.idlesson = A.idlesson 
WHERE NOT EXISTS (SELECT *
                  FROM Athletes AH
                  WHERE AH.idathlete = A.idathlete and
                        (SELECT COUNT(*)
                         FROM Follows F
                         WHERE F.idathletefollowed = AH.idathlete) <= 1
                  )
GROUP BY U.firstname, U.lastname
HAVING AVG(A.rating) > (SELECT AVG(A1.rating)
                        FROM Attendance A1 JOIN Lessons L1 ON L1.idlesson = A1.idlesson 
                        WHERE EXTRACT(YEAR FROM L1.date) = 2025)