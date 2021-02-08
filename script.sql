CREATE TABLE faculty(
faculty_code smallint NOT NULL PRIMARY KEY,
name character(20) NOT NULL,
abbreviation character(10)
);

CREATE TABLE course(
course_code smallint NOT NULL PRIMARY KEY,
name character(20) NOT NULL,
faculty_code smallint NOT NULL,
FOREIGN KEY(faculty_code) REFERENCES faculty(faculty_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE groups(
group_number character(20) NOT NULL PRIMARY KEY,
name character(20) NOT NULL,
course_code smallint NOT NULL,
FOREIGN KEY(course_code) REFERENCES course(course_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE order_type(
order_type_id smallint NOT NULL PRIMARY KEY,
name character(20) NOT NULL
);

CREATE TABLE orders(
order_number smallint NOT NULL PRIMARY KEY,
order_points character(50) NOT NULL,
order_type_id smallint NOT NULL,
FOREIGN KEY(order_type_id) REFERENCES order_type(order_type_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE student(
student_id smallint NOT NULL PRIMARY KEY,
full_name character(50) NOT NULL,
date_of_birth character(50) NOT NULL,
phone_number character(20),
address character(20),
group_number character(10) NOT NULL,
order_number smallint NOT NULL,
FOREIGN KEY(group_number) REFERENCES groups(group_number) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(order_number) REFERENCES orders(order_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE enrollee(
enrollee_id smallint NOT NULL PRIMARY KEY,
full_name character(50) NOT NULL,
date_of_birth date NOT NULL,
phone_number character(20) ,
address character(50),
exam_scores smallint NOT NULL,
course_code smallint NOT NULL,
CHECK( (exam_scores >= 0) AND (exam_scores <= 100) ),
FOREIGN KEY(course_code) REFERENCES course(course_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE student_move(
student_move_id smallint NOT NULL PRIMARY KEY,
student_id smallint NOT NULL,
order_number smallint NOT NULL,
FOREIGN KEY(student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(order_number) REFERENCES orders(order_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE department(
department_code smallint NOT NULL PRIMARY KEY,
name character(20) NOT NULL,
abbreviation character(10),
faculty_code smallint NOT NULL,
FOREIGN KEY(faculty_code) REFERENCES faculty(faculty_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE discipline(
discipline_code smallint NOT NULL PRIMARY KEY,
name smallint NOT NULL,
department_code smallint NOT NULL,
FOREIGN KEY(department_code) REFERENCES department(department_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE curriculum_discipline(
cur_discipline_id smallint NOT NULL PRIMARY KEY,
discipline_code smallint NOT NULL,
course_number smallint NOT NULL,
semester smallint NOT NULL,
lesson_type character(20) NOT NULL,
CHECK( (course_number >= 1) AND (course_number <= 4) ),
CHECK( (semester >= 1) AND (semester <= 8) ),
FOREIGN KEY(discipline_code) REFERENCES discipline(discipline_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE grade(
grade_id smallint NOT NULL PRIMARY KEY,
student_id smallint NOT NULL,
grade smallint NOT NULL,
exam_date date,
cur_discipline_id smallint NOT NULL,
CHECK( (grade >= 2) AND (grade <= 5) ),
FOREIGN KEY(student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(cur_discipline_id) REFERENCES curriculum_discipline(cur_discipline_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE scholarship_type(
scholar_type_id smallint NOT NULL PRIMARY KEY,
name  character(20) NOT NULL,
payment_amount real NOT NULL,
CHECK( payment_amount > 0 )
);

CREATE TABLE scholarship(
scholar_id smallint NOT NULL PRIMARY KEY,
student_id smallint NOT NULL,
scholar_type_id smallint NOT NULL,
order_number smallint NOT NULL,
FOREIGN KEY(student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(scholar_type_id) REFERENCES scholarship_type(scholar_type_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(order_number) REFERENCES orders(order_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE salary(
salary_id smallint NOT NULL PRIMARY KEY,
payment_amount real NOT NULL,
order_number smallint NOT NULL,
CHECK( payment_amount > 0 ),
FOREIGN KEY(order_number) REFERENCES orders(order_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE professor(
professor_id smallint NOT NULL PRIMARY KEY,
full_name character(50) NOT NULL,
phone_number character(20),
address character(50),
department_code smallint NOT NULL,
position character(20) NOT NULL,
degree character(20) NOT NULL,
salary_id smallint NOT NULL,
FOREIGN KEY(department_code) REFERENCES department(department_code) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(salary_id) REFERENCES salary(salary_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE schedule(
schedule_id smallint NOT NULL PRIMARY KEY,
group_number character NOT NULL,
professor_id smallint NOT NULL,
cur_discipline_id smallint NOT NULL,
lesson_time time NOT NULL,
classroom character(20) NOT NULL,
FOREIGN KEY(group_number) REFERENCES groups(group_number) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(professor_id) REFERENCES professor(professor_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(cur_discipline_id) REFERENCES curriculum_discipline(cur_discipline_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE professor_move(
professor_move_id smallint NOT NULL PRIMARY KEY,
professor_id smallint NOT NULL,
order_number smallint NOT NULL,
FOREIGN KEY(professor_id) REFERENCES professor(professor_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(order_number) REFERENCES orders(order_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE order_acception(
order_accept_id smallint NOT NULL PRIMARY KEY,
order_number smallint NOT NULL,
status character(20) NOT NULL,
acception_date date NOT NULL,
signed_by character(20),
FOREIGN KEY(order_number) REFERENCES orders(order_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE enrollee_document(
enrollee_doc_id smallint NOT NULL PRIMARY KEY,
enrollee_id smallint NOT NULL,
doc_type character(20) NOT NULL,
date_of_issue date,
place_of_issue character(50),
FOREIGN KEY(enrollee_id) REFERENCES enrollee(enrollee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE student_document(
student_doc_id smallint NOT NULL PRIMARY KEY,
student_id smallint NOT NULL,
doc_type character(20) NOT NULL,
date_of_issue date,
place_of_issue character(50),
FOREIGN KEY(student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE professor_document(
prof_doc_id smallint NOT NULL PRIMARY KEY,
professor_id smallint NOT NULL,
doc_type character(20) NOT NULL,
date_of_issue date,
place_of_issue character(50) ,
FOREIGN KEY(professor_id) REFERENCES professor(professor_id) ON DELETE CASCADE ON UPDATE CASCADE
);
