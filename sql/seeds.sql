SET search_path TO fitzone;

INSERT INTO activity_types (idactivitytype, name, description) VALUES
(1, 'Weight Room', 'Access to gym equipment'),
(2, 'Group Classes', 'Instructor-led group sessions'),
(3, 'Spa & Wellness', 'Sauna and relaxation area');

INSERT INTO duration_types (iddurationtype, name, description) VALUES
(1, 'Monthly', '30 days validity'),
(2, 'Quarterly', '90 days validity'),
(3, 'Yearly', '365 days validity');

INSERT INTO course_types (idcoursetype, name, description) VALUES
(1, 'CrossFit', 'High-intensity power training'),
(2, 'Pilates', 'Core and posture focus'),
(3, 'Yoga', 'Hatha and Vinyasa flow'),
(4, 'Boxing', 'Combat conditioning');

INSERT INTO rooms (idroom, name, capacity, is_weight_room) VALUES
(1, 'Studio A', 25, FALSE),
(2, 'Studio B', 15, FALSE),
(3, 'Main Weight Floor', 60, TRUE),
(4, 'Outdoor Box', 30, FALSE);

INSERT INTO users (iduser, firstname, lastname, password, email) VALUES
(1, 'James', 'Smith', 'pass123', 'admin1@fitzone.com'),
(2, 'Mary', 'Johnson', 'pass123', 'admin2@fitzone.com'),
(3, 'Robert', 'Williams', 'pass123', 'robert.trainer@fitzone.com'),
(4, 'Patricia', 'Brown', 'pass123', 'patricia.coach@fitzone.com'),
(5, 'Michael', 'Jones', 'pass123', 'michael.instructor@fitzone.com'),
(6, 'Linda', 'Garcia', 'pass123', 'linda.yoga@fitzone.com'),
(7, 'David', 'Miller', 'pass123', 'david.athlete@gmail.com'),
(8, 'Barbara', 'Davis', 'pass123', 'barbara.athlete@gmail.com'),
(9, 'William', 'Rodriguez', 'pass123', 'william.athlete@gmail.com'),
(10, 'Elizabeth', 'Martinez', 'pass123', 'elizabeth.athlete@gmail.com'),
(11, 'Richard', 'Hernandez', 'pass123', 'richard.athlete@gmail.com');

INSERT INTO administrators (idadministrator) VALUES (1), (2);
INSERT INTO instructors (idinstructor) VALUES (3), (4), (5), (6);
INSERT INTO athletes (idathlete, residence_city) VALUES (7, 'New York'), (8, 'London'), (9, 'Paris'), (10, 'Berlin'), (11, 'Rome');

INSERT INTO phone_numbers (idphonenumber, number, idinstructor) VALUES
(1, '+15550101', 3), (2, '+15550102', 4), (3, '+15550103', 5), (4, '+15550104', 6);

INSERT INTO courses (idcourse, title, description, lesson_duration, idinstructor, idroom, idcoursetype) VALUES
(1, 'CrossFit Elite', 'Intense performance training', 60, 3, 4, 1),
(2, 'Core Pilates Elite', 'Beginner to intermediate', 45, 4, 1, 2),
(3, 'Zen Yoga Flow', 'Relaxation and flexibility', 90, 6, 2, 3),
(4, 'Boxe Fit', 'No-contact cardio boxing', 60, 5, 4, 4);

INSERT INTO lessons (idlesson, date, time, idcourse) VALUES
(1, '2025-06-01', '09:00:00', 1), (2, '2025-06-03', '09:00:00', 1),
(3, '2025-06-01', '10:00:00', 2), (4, '2025-06-04', '10:00:00', 2),
(5, '2025-06-02', '18:00:00', 3), (6, '2025-06-05', '18:00:00', 3),
(7, '2025-06-02', '19:30:00', 4);

INSERT INTO membership_types (idmembershiptype, name, price, idactivitytype, iddurationtype) VALUES
(1, 'Basic Weights', 45.00, 1, 1), (2, 'Silver Courses', 120.00, 2, 2), (3, 'Gold Full Access', 400.00, 3, 3);

INSERT INTO memberships (idmembership, start_date, idathlete, idmembershiptype, idadministrator) VALUES
(1, '2025-01-10', 7, 3, 1), (2, '2025-02-01', 8, 2, 1), (3, '2025-03-01', 9, 1, 2), (4, '2025-01-01', 10, 3, 2), (5, '2025-04-15', 11, 2, 1);

INSERT INTO membership_courses (idmembership, idcourse) VALUES (1,1), (1,2), (1,3), (1,4), (2,2), (2,4), (4,1), (4,3);

INSERT INTO enrollments (idathlete, idcourse, comment) VALUES 
(7, 1, 'Looking for strength'), (8, 2, 'Core goals'), (9, 1, 'Back to gym'), (10, 4, 'Fun workout'), (11, 3, 'Flexibility');

INSERT INTO follows (idathlete, idathletefollowed) VALUES 
(8, 7), (9, 7),
(7, 10), (11, 10);

INSERT INTO attendance (idathlete, idlesson, rating) VALUES 
(7, 1, 5),
(10, 2, 5);

INSERT INTO attendance (idathlete, idlesson, rating) VALUES 
(8, 7, 2);

INSERT INTO monthly_awards (idaward, month, year, role, iduser) VALUES 
(1, 6, 2025, 'Top Instructor', 3), 
(2, 6, 2025, 'Staff Excellence', 1);