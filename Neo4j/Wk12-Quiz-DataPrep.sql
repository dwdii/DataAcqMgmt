CREATE TABLE courses
(
	ID INT,
	GivenName VARCHAR(32),
	Surname VARCHAR(32),
	CourseDept VARCHAR(32),
	CourseNumber VARCHAR(32),
	CourseName VARCHAR(32),
	Grade VARCHAR(32),
	Section VARCHAR(32),
	Instructor VARCHAR(32)
)

CREATE TABLE housing
(
	ID INT,
	Gender VARCHAR(32),
	GivenName VARCHAR(32),
	Surname VARCHAR(32),
	StreetAddress VARCHAR(32),
	City VARCHAR(32),
	State VARCHAR(32),
	ZipCode VARCHAR(32),
	TelephoneNumber VARCHAR(32),
	Dormitory VARCHAR(32),
	Room VARCHAR(32)
)

SELECT * FROM courses

SELECT DISTINCT coursenumber, coursename FROM courses

SELECT DISTINCT dormitory from housing

SELECT * FROM courses WHERE grade != 'IP'