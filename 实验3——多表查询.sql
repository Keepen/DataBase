use Study

--1.����ͬѧ��ѧ�š��������γ̺š��γ̳ɼ�
select Student.s_no,Student.s_name,Choice.course_no,score
from Student,Choice
where Student.s_no=Choice.s_no
--drop new_table

--2.������ͬѧ���������γ������ɼ�����ŵ�һ���±�new_table��
select Student.s_name ,Course.course_name,score
into new_table
from Student,Course,Choice
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no 

--3.�����99-1 ���ͬѧѧ�š��������γ̺š��γ����ơ��γ̳ɼ�
select Student.s_no,Student.s_name,Course.course_no,Course.course_name,score--,Class.class_name
from Student,Course,Choice,Class
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no and 
	Student.class_no=Class.class_no and CLass.class_name='�����99-1'
	
--4.����ѧ����ѧ�֣��ɼ�>=60ʱ���Ի�øÿγ�ѧ�֣���ʾѧ�ţ���������ѧ��
select Student.s_no,Student.s_name,SUM(course_score) as total_score
from Student inner join Choice on (Student.s_no=Choice.s_no) 
	inner join Course on(Course.course_no=Choice.course_no) 	
--on /*Student.s_no=Choice.s_no and Course.course_no=Choice.course_no and */score>=60
group by Student.s_no,Student.s_name

--5.����ѧ����ƽ���ɼ�ѡ��������ѧ�š�������ƽ���ɼ���ѡ������
select Student.s_no,Student.s_name,AVG(score) as average_score,COUNT(*) as choice_num
from Student,Choice
where Student.s_no=Choice.s_no
group by Student.s_no,Student.s_name

--6.����ѡ�ε�δ�μӿ��Ե�ѧ����ѧ�ţ��������γ̺ţ��γ�����
select Student.s_no,Student.s_name,Course.course_no,Course.course_name
from Student,Choice,Course
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no 
	and score is null
	
--7.���пγ̲������ѧ����ѧ�ţ��������γ̺ţ��γ�����ѧ��
select Student.s_no,Student.s_name,Course.course_no,Course.course_name,Course.course_score
from Student,Course,Choice
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no and score<60





--8.ѡ���ˡ�����������ԡ���ѧ���ɼ������ѧ���������γ̳ɼ�
/*������-----
select Student.s_name,score
from Student,Choice
where Student.s_no in
	(select Choice.s_no
	from Choice,Course
	where Choice.course_no=Course.course_no and Course.course_name='�����������'
	) and Student.s_no=Choice.s_no
*/	
	
select Student.s_name,score
from Student,Course,Choice
where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no 
and Course.course_name='�����������'
	

--9/�����ϵѧ��ѧ�š��������༶���ơ��γ̺š��γ����ơ��ɼ�
select Student.s_no,Student.s_name,Class.class_name,Course.course_no,Course.course_name,score
from Student,Choice,Course,Class
where Student.s_no=Choice.s_no and Student.class_no=Class.class_no
	and Course.course_no=Choice.course_no and Class.class_dept='�����ϵ'
	
--10.���ڽ�ʦ�ο��������ʦ�������γ���
select Teacher.t_name,Course.course_name
from Teaching ,Teacher,Course
where Teaching.t_no=Teacher.t_no and Teaching.course_no=Course.course_no

--11.������ʦ���ο���������ʦ�������ο�����
select Teacher.t_name,COUNT(*) as course_number
from Teaching,Teacher
where Teaching.t_no=Teacher.t_no
group by Teacher.t_no,Teacher.t_name

--12.�����ٵ�ͬ��ͬѧ������
select Student.s_name
from Student
where Student.class_no =
	(select Student.class_no
	from Student
	where Student.s_name='����'
	)
	
--13.û��ѡ�ޡ��������������ͬѧ������
select Student.s_name
from Student
where Student.s_no not in
	(select Student.s_no
	from Student,Course,Choice
	where Student.s_no=Choice.s_no and Course.course_no=Choice.course_no
	and Course.course_name='���������' 
	)

--14.�������ݿ�ԭ����Ӧ�á��͡����ݽṹ���Ľ�ʦ����
select Teacher.t_name
from Teacher
where Teacher.t_no in
	(select Teaching.t_no
	from Teaching,Course
	where Teaching.course_no=Course.course_no and Course.course_name='���ݿ�ԭ����Ӧ��'
	)
union
select Teacher.t_name
from Teacher
where Teacher.t_no in
	(select Teaching.t_no
	from Teaching,Course
	where Teaching.course_no=Course.course_no and Course.course_name='���ݽṹ'
	)
select Teacher.t_name
from Teacher,Course,Teaching
where Teacher.t_no=Teaching.t_no and Course.course_no=Teaching.course_no and 
Course.course_name in('���ݿ�ԭ����Ӧ��','���ݽṹ')



--15.���ڡ����ݿ�ԭ����Ӧ�á��Ľ�ʦ����
select Teacher.t_name
from Teacher
where Teacher.t_no in
	(select Teaching.t_no
	from Teaching,Course
	where Teaching.course_no=Course.course_no and Course.course_name='���ݿ�ԭ����Ӧ��'
	)
	
select Teacher.t_name
from Teacher,Course,Teaching
where Teacher.t_no=Teaching.t_no and Course.course_no=Teaching.course_no and 
Course.course_name ='���ݿ�ԭ����Ӧ��'


--My1.��ѯְ���ǽ��ڵĽ�ʦ�����ڵĿγ̣���ʦ�����γ���
select Teacher.t_name,Course.course_name
from Teacher,Course,Teaching
where Teacher.t_title='����' and Teacher.t_no=Teaching.t_no and Teaching.course_no=Course.course_no

--My2.��ѯÿ����ʦ�����ڵ�ѧ������,��ʦ�������γ�����ѧ��������s_num
select Teacher.t_name,Course.course_name,COUNT(*) as s_num
from Teacher,Course,Teaching,Choice
where Teacher.t_no=Teaching.t_no and Course.course_no=Teaching.course_no
and Choice.course_no=Course.course_no
group by Teacher.t_name,Course.course_name

--My3.�ű�ѧ��ѡ�ε���ʦ���γ�������ʦ��
select Course.course_name,Teacher.t_name
from Course,Teacher,Choice,Teaching,Student
where Course.course_no=Choice.course_no and Teacher.t_no=Teaching.t_no
	and Teaching.course_no=Choice.course_no and Student.s_no=Choice.s_no and s_name='�ű�'

--My4.�ű�ѧ���ĸ��Ƴɼ��е���߷֣��������ɼ�
select s_name,max(score) as max_score
from Course,Choice,Student
where Course.course_no=Choice.course_no and Choice.s_no=Student.s_no
	and s_name='�ű�'
group by s_name

--My.5�г�ÿһ�ſε���߷֣��γ������ɼ�
select course_name,max(score) max_score
from Course,Choice
where Course.course_no=Choice.course_no 
group by course_name

--My6.��ѯ���ڡ�������������ģ���ʦ������ְ��
select t_name,t_title
from Teacher,Teaching,Course
where Teacher.t_no=Teaching.t_no and Course.course_no=Teaching.course_no
	and course_name='���������'

--My7.��ѯѡ��������ɽ��ʦ����������Ե�ѧ���������ɼ�
select s_name,score
from Student,Choice,Teacher,Teaching,Course
where Student.s_no=Choice.s_no and Teacher.t_no=Teaching.t_no
	and Teaching.course_no=Course.course_no and Choice.course_no=Course.course_no and course_name='�����������'
	and t_name='����ɽ'

--8.��ѯ���ѧ���ĸ��Ƴɼ����γ������ɼ�
select course_name,score
from Student,Course,Choice
where Student.s_no=Choice.s_no and Choice.course_no=Course.course_no
	and s_name='���' 

--9.��ѯ��Ϣϵѧ������������ʾ��ϵ����ѧ������
select class_dept,count(*) as s_num
from Student,Class
where Student.class_no=Class.class_no and class_dept='��Ϣϵ'
group by class_dept

--10.ÿ��ͬѧѡ�޵Ŀγ̵���ѧ�֣�ѧ����������ѧ��
select s_name,count(course_score)as total_score
from Student left outer join Choice on(Student.s_no=Choice.s_no)
	left outer join Course on (Choice.course_no=Course.course_no)
group by Student.s_no,s_name
