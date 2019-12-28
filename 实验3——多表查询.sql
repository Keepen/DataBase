use Study

--1.所有同学的学号、姓名、课程号、课程成绩
select Student.s_no,Student.s_name,Choice.course_no,score
from Student,Choice
where Student.s_no=Choice.s_no
--drop new_table

--2.将所有同学的姓名、课程名、成绩、存放到一个新表new_table中
select Student.s_name ,Course.course_name,score
into new_table
from Student,Course,Choice
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no 

--3.计算机99-1 班的同学学号、姓名、课程号、课程名称、课程成绩
select Student.s_no,Student.s_name,Course.course_no,Course.course_name,score--,Class.class_name
from Student,Course,Choice,Class
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no and 
	Student.class_no=Class.class_no and CLass.class_name='计算机99-1'
	
--4.所有学生的学分，成绩>=60时可以获得该课程学分，显示学号，姓名，总学分
select Student.s_no,Student.s_name,SUM(course_score) as total_score
from Student inner join Choice on (Student.s_no=Choice.s_no) 
	inner join Course on(Course.course_no=Choice.course_no) 	
--on /*Student.s_no=Choice.s_no and Course.course_no=Choice.course_no and */score>=60
group by Student.s_no,Student.s_name

--5.所有学生的平均成绩选课门数，学号、姓名、平均成绩、选课门数
select Student.s_no,Student.s_name,AVG(score) as average_score,COUNT(*) as choice_num
from Student,Choice
where Student.s_no=Choice.s_no
group by Student.s_no,Student.s_name

--6.所有选课但未参加考试的学生，学号，姓名，课程号，课程名称
select Student.s_no,Student.s_name,Course.course_no,Course.course_name
from Student,Choice,Course
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no 
	and score is null
	
--7.所有课程不及格的学生的学号，姓名，课程号，课程名，学分
select Student.s_no,Student.s_name,Course.course_no,Course.course_name,Course.course_score
from Student,Course,Choice
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no and score<60





--8.选修了“程序设计语言”的学生成绩情况，学生姓名、课程成绩
/*有问题-----
select Student.s_name,score
from Student,Choice
where Student.s_no in
	(select Choice.s_no
	from Choice,Course
	where Choice.course_no=Course.course_no and Course.course_name='程序设计语言'
	) and Student.s_no=Choice.s_no
*/	
	
select Student.s_name,score
from Student,Course,Choice
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no 
and Course.course_name='程序设计语言'
	

--9/计算机系学生学号、姓名、班级名称、课程号、课程名称、成绩
select Student.s_no,Student.s_name,Class.class_name,Course.course_no,Course.course_name,score
from Student,Choice,Course,Class
where Student.s_no=Choice.s_no and Student.class_no=Class.class_no
	and Course.course_no=Choice.course_no and Class.class_dept='计算机系'
	
--10.所在教师任课情况：教师姓名、课程名
select Teacher.t_name,Course.course_name
from Teaching ,Teacher,Course
where Teaching.t_no=Teacher.t_no and Teaching.course_no=Course.course_no

--11.所有老师的任课门数，教师姓名、任课门数
select Teacher.t_name,COUNT(*) as course_number
from Teaching,Teacher
where Teaching.t_no=Teacher.t_no
group by Teacher.t_no,Teacher.t_name

--12.和王蕾的同班同学的姓名
select Student.s_name
from Student
where Student.class_no =
	(select Student.class_no
	from Student
	where Student.s_name='王蕾'
	)
	
--13.没有选修“计算机基础”的同学的姓名
select Student.s_name
from Student
where Student.s_no not in
	(select Student.s_no
	from Student,Course,Choice
	where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no
	and Course.course_name='计算机基础' 
	)

--14.将“数据库原理与应用”和“数据结构”的教师姓名
select Teacher.t_name
from Teacher
where Teacher.t_no in
	(select Teaching.t_no
	from Teaching,Course
	where Teaching.course_no=Course.course_no and Course.course_name='数据库原理与应用'
	)
union
select Teacher.t_name
from Teacher
where Teacher.t_no in
	(select Teaching.t_no
	from Teaching,Course
	where Teaching.course_no=Course.course_no and Course.course_name='数据结构'
	)
select Teacher.t_name
from Teacher,Course,Teaching
where Teacher.t_no=Teaching.t_no and Course.course_no=Teaching.course_no and 
Course.course_name in('数据库原理与应用','数据结构')



--15.讲授“数据库原理与应用”的教师姓名
select Teacher.t_name
from Teacher
where Teacher.t_no in
	(select Teaching.t_no
	from Teaching,Course
	where Teaching.course_no=Course.course_no and Course.course_name='数据库原理与应用'
	)
	
select Teacher.t_name
from Teacher,Course,Teaching
where Teacher.t_no=Teaching.t_no and Course.course_no=Teaching.course_no and 
Course.course_name ='数据库原理与应用'


--My1.查询职称是教授的教师所教授的课程，教师名、课程名
select Teacher.t_name,Course.course_name
from Teacher,Course,Teaching
where Teacher.t_title='教授' and Teacher.t_no=Teaching.t_no and Teaching.course_no=Course.course_no

--My2.查询每个老师所教授的学生人数,教师姓名、课程名、学生人数：s_num
select Teacher.t_name,Course.course_name,COUNT(*) as s_num
from Teacher,Course,Teaching,Choice
where Teacher.t_no=Teaching.t_no and Course.course_no=Teaching.course_no
and Choice.course_no=Course.course_no
group by Teacher.t_name,Course.course_name

--My3.张彬学生选课的老师，课程名、教师名
select Course.course_name,Teacher.t_name
from Course,Teacher,Choice,Teaching,Student
where Course.course_no=Choice.course_no and Teacher.t_no=Teaching.t_no
	and Teaching.course_no=Choice.course_no and Student.s_no=Choice.s_no and s_name='张彬'

--My4.张彬学生的各科成绩中的最高分：姓名、成绩
select s_name,max(score) as max_score
from Course,Choice,Student
where Course.course_no=Choice.course_no and Choice.s_no=Student.s_no
	and s_name='张彬'
group by s_name

--My.5列出每一门课的最高分：课程名、成绩
select course_name,max(score) max_score
from Course,Choice
where Course.course_no=Choice.course_no 
group by course_name

--My6.查询教授“计算机基础”的：教师姓名与职称
select t_name,t_title
from Teacher,Teaching,Course
where Teacher.t_no=Teaching.t_no and Course.course_no=Teaching.course_no
	and course_name='计算机基础'

--My7.查询选修了王大山老师程序设计语言的学生姓名、成绩
select s_name,score
from Student,Choice,Teacher,Teaching,Course
where Student.s_no=Choice.s_no and Teacher.t_no=Teaching.t_no
	and Teaching.course_no=Course.course_no and Choice.course_no=Course.course_no and course_name='程序设计语言'
	and t_name='王大山'

--8.查询李建国学生的各科成绩，课程名、成绩
select course_name,score
from Student,Course,Choice
where Student.s_no=Choice.s_no and Choice.course_no=Course.course_no
	and s_name='李建国' 

--9.查询信息系学生的人数，显示：系名、学生人数
select class_dept,count(*) as s_num
from Student,Class
where Student.class_no=Class.class_no and class_dept='信息系'
group by class_dept

--10.每个同学选修的课程的总学分，学生姓名、总学分
select s_name,count(course_score)as total_score
from Student left outer join Choice on(Student.s_no=Choice.s_no)
	left outer join Course on (Choice.course_no=Course.course_no)
group by Student.s_no,s_name
