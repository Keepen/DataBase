use Study
--1.查询所有学生的基本信息：
select *
from Student

--2.查询所有学生的学号,显示其学号、姓名
select s_no,s_name
from Student

--3.查询所有男同学，显示其学号，姓名，出生日期
select s_no,s_name,s_birthday
from Student
where s_sex='男'

--4.查询所有出生日期在“1980-01-01”前的女同学的学号、姓名、性别、出生日期
select s_no,s_name,s_sex,s_birthday
from Student
where (s_sex='女') and (s_birthday < '1980-01-01')

--5.查询所有姓李的男同学，学号、姓名、性别、出生日期
select s_no,s_name,s_sex,s_birthday
from Student
where (s_sex='男' ) and (s_name like '李%')

--6.查询所有姓名中含有“一”字的同学的 学号、姓名
select s_no,s_name
from Student
where s_name like '%一%'

--7.查询所有职称不是“讲师”的教师，教师好，姓名，职称
select t_no,t_name,t_title
from Teacher
where t_title <> '讲师'

--8.查询虽选修了课程，单位参加考试的所有同学的学号
select s_no
from Choice
where score is null

--9.查询所有考试不及格的同学的学号，成绩，成绩降序
select s_no,score
from Choice
where score < 60
order by score desc

--10.查询课程号为01001，02001，02003的所有课程，的课程号，课程名名称
select course_no,course_name
from Course
where course_no in ('01001','02001','02003')

--11.查询1970年出生的教师的教师号，姓名，出生日期
select t_no,t_name,t_birthday
from Teacher
where t_birthday <= '1970-12-31' and t_birthday >= '1970-01-01'

--12.查询各个课程号即相应的选课人数
select course_no,count(distinct s_no) as 选课人数
from Choice
group by course_no

--13.查询教授两门课以上的教师号
select t_no
from Teaching
group by t_no
having count(*) >= 2

--14.查询选修了01001课程的学生平均分数、最低分数、最高分数
select avg(score) as 平均分数, min(score) as 最低分数,max(score) as 最高分数 
from Choice
group by course_no
having course_no = 01001

--15.查询1960年后出生的，职称为讲师的教师的姓名，出生日期，并将出生日期升序排列
select t_name,t_birthday
from Teacher
where t_birthday > '1960-12-31'
order by t_birthday asc   --asc可要可不要，默认升序

--MY.1查询出每个学生的选课门数，以及学生的学号，姓名
select Choice.s_no,s_name,count (distinct course_no) as 选课门数
from Student,Choice
where Student.s_no=Choice.s_no
group by Choice.s_no,s_name


--MY.2查询学分大于2分的课程的平均成绩,显示出课程号、课程名、平均成绩、课程学分
select Course.course_no,Course.course_name,Course.course_score,avg(score) as 平均成绩
from Course,Choice
where Course.course_no=Choice.course_no and Course.course_score > 2
group by Course.course_no,Course.course_name,Course.course_score

--MY.3查询每个老师所教授的课的教师号、课号、课名、课程学分
select Teaching.t_no,Course.course_no,Course.course_name,Course.course_score
from Course,Teaching
where Course.course_no=Teaching.course_no
group by Teaching.t_no,Course.course_no,Course.course_name,Course.course_score

--MY.4查询选修了01002课程的学生的姓名、平均成绩（按照降序排列）
select Student.s_name,avg(score) as 平均成绩
from Student,Choice
where Student.s_no=Choice.s_no --and Choice.course_no=01002
group by Choice.course_no,Student.s_name
having Choice.course_no=01002
order by 平均成绩 desc

--MY.5查询计算机系各班级的平均成绩，班级号，以及平均成绩
select Student.class_no,avg(score) as 平均成绩
from Student,Choice
where Student .s_no=Choice.s_no
group by Student.class_no
