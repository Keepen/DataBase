use Study
--1.创建视图SubS：学号、姓名、出生日期
create view SubS
as select s_no,s_name,s_birthday
from Student

--2.选课视图S_SC_C:学号、姓名、选课、成绩
create view S_SC_C
as select Student.s_no,s_name,course_name,score
from Student,Choice,Course
where Student.s_no=Choice.s_no and Choice.course_no=Course.course_no

--3.平均成绩视图S_Avg：学号、平均成绩
create view S_Avg
as select Student.s_no,avg(score) as avg_score
from Student,Choice
where Student.s_no=Choice.s_no 
group by Student.s_no
drop view V_Class
--4.班级视图V_Class：班号、班级名称、班级人数
create view V_Class
as select Class.class_no,class_name,count(distinct s_no) as class_num
from Student right outer join Class 
	on(Student.class_no=Class.class_no)
group by Class.class_no,Class.class_name

--5.教师授课视图V_Teaching：教师号、教师姓名、授课名称
create view V_Teaching
as select Teacher.t_no,Teacher.t_name,course.course_name
from Teacher,Teaching,Course
where Teacher.t_no=Teaching.t_no and Teaching.course_no=Course.course_no

--6.使用视图“S_SC_C”查询“张彬”的选修课程名及成绩
select course_name,score
from S_SC_C
where s_name='张彬'

--7.使用视图“S_Avg”查询学号为“991102”的学生平均成绩
select avg_score
from S_Avg
where s_no=991102

--8.删除视图S_Avg
Drop view S_Avg

--My1.在视图“SubS”中查询学号为“991102”的学生姓名
select s_name
from SubS
where s_no=991102

--My2.在“V_Class”视图中查询班级号为“js9901”的班级名称、班级人数
select class_name,class_num
from V_Class
where class_no='js9901'

--My3.在“V_Teaching”视图中查询教授“数据结构”的教师姓名
select t_name
from V_Teaching
where course_name='数据结构'

--My4.使用视图查询学号为“991102”的学生姓名、平均成绩
select s_name,avg_score
from SubS,S_Avg
where SubS.s_no=S_Avg.s_no

--My5.查询选修了“王大山”老师所教的“程序设计语言”学生姓名，及成绩
select s_name,score
from S_SC_C,V_Teaching
where S_SC_C.course_name=V_Teaching.course_name and t_name='王大山' and V_Teaching.course_name='程序设计语言'

