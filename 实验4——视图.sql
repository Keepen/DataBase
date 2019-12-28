use Study
--1.������ͼSubS��ѧ�š���������������
create view SubS
as select s_no,s_name,s_birthday
from Student

--2.ѡ����ͼS_SC_C:ѧ�š�������ѡ�Ρ��ɼ�
create view S_SC_C
as select Student.s_no,s_name,course_name,score
from Student,Choice,Course
where Student.s_no=Choice.s_no and Choice.course_no=Course.course_no

--3.ƽ���ɼ���ͼS_Avg��ѧ�š�ƽ���ɼ�
create view S_Avg
as select Student.s_no,avg(score) as avg_score
from Student,Choice
where Student.s_no=Choice.s_no 
group by Student.s_no
drop view V_Class
--4.�༶��ͼV_Class����š��༶���ơ��༶����
create view V_Class
as select Class.class_no,class_name,count(distinct s_no) as class_num
from Student right outer join Class 
	on(Student.class_no=Class.class_no)
group by Class.class_no,Class.class_name

--5.��ʦ�ڿ���ͼV_Teaching����ʦ�š���ʦ�������ڿ�����
create view V_Teaching
as select Teacher.t_no,Teacher.t_name,course.course_name
from Teacher,Teaching,Course
where Teacher.t_no=Teaching.t_no and Teaching.course_no=Course.course_no

--6.ʹ����ͼ��S_SC_C����ѯ���ű򡱵�ѡ�޿γ������ɼ�
select course_name,score
from S_SC_C
where s_name='�ű�'

--7.ʹ����ͼ��S_Avg����ѯѧ��Ϊ��991102����ѧ��ƽ���ɼ�
select avg_score
from S_Avg
where s_no=991102

--8.ɾ����ͼS_Avg
Drop view S_Avg

--My1.����ͼ��SubS���в�ѯѧ��Ϊ��991102����ѧ������
select s_name
from SubS
where s_no=991102

--My2.�ڡ�V_Class����ͼ�в�ѯ�༶��Ϊ��js9901���İ༶���ơ��༶����
select class_name,class_num
from V_Class
where class_no='js9901'

--My3.�ڡ�V_Teaching����ͼ�в�ѯ���ڡ����ݽṹ���Ľ�ʦ����
select t_name
from V_Teaching
where course_name='���ݽṹ'

--My4.ʹ����ͼ��ѯѧ��Ϊ��991102����ѧ��������ƽ���ɼ�
select s_name,avg_score
from SubS,S_Avg
where SubS.s_no=S_Avg.s_no

--My5.��ѯѡ���ˡ�����ɽ����ʦ���̵ġ�����������ԡ�ѧ�����������ɼ�
select s_name,score
from S_SC_C,V_Teaching
where S_SC_C.course_name=V_Teaching.course_name and t_name='����ɽ' and V_Teaching.course_name='�����������'

