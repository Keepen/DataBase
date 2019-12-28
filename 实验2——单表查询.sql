use Study
--1.��ѯ����ѧ���Ļ�����Ϣ��
select *
from Student

--2.��ѯ����ѧ����ѧ��,��ʾ��ѧ�š�����
select s_no,s_name
from Student

--3.��ѯ������ͬѧ����ʾ��ѧ�ţ���������������
select s_no,s_name,s_birthday
from Student
where s_sex='��'

--4.��ѯ���г��������ڡ�1980-01-01��ǰ��Ůͬѧ��ѧ�š��������Ա𡢳�������
select s_no,s_name,s_sex,s_birthday
from Student
where (s_sex='Ů') and (s_birthday < '1980-01-01')

--5.��ѯ�����������ͬѧ��ѧ�š��������Ա𡢳�������
select s_no,s_name,s_sex,s_birthday
from Student
where (s_sex='��' ) and (s_name like '��%')

--6.��ѯ���������к��С�һ���ֵ�ͬѧ�� ѧ�š�����
select s_no,s_name
from Student
where s_name like '%һ%'

--7.��ѯ����ְ�Ʋ��ǡ���ʦ���Ľ�ʦ����ʦ�ã�������ְ��
select t_no,t_name,t_title
from Teacher
where t_title <> '��ʦ'

--8.��ѯ��ѡ���˿γ̣���λ�μӿ��Ե�����ͬѧ��ѧ��
select s_no
from Choice
where score is null

--9.��ѯ���п��Բ������ͬѧ��ѧ�ţ��ɼ����ɼ�����
select s_no,score
from Choice
where score < 60
order by score desc

--10.��ѯ�γ̺�Ϊ01001��02001��02003�����пγ̣��Ŀγ̺ţ��γ�������
select course_no,course_name
from Course
where course_no in ('01001','02001','02003')

--11.��ѯ1970������Ľ�ʦ�Ľ�ʦ�ţ���������������
select t_no,t_name,t_birthday
from Teacher
where t_birthday <= '1970-12-31' and t_birthday >= '1970-01-01'

--12.��ѯ�����γ̺ż���Ӧ��ѡ������
select course_no,count(distinct s_no) as ѡ������
from Choice
group by course_no

--13.��ѯ�������ſ����ϵĽ�ʦ��
select t_no
from Teaching
group by t_no
having count(*) >= 2

--14.��ѯѡ����01001�γ̵�ѧ��ƽ����������ͷ�������߷���
select avg(score) as ƽ������, min(score) as ��ͷ���,max(score) as ��߷��� 
from Choice
group by course_no
having course_no = 01001

--15.��ѯ1960�������ģ�ְ��Ϊ��ʦ�Ľ�ʦ���������������ڣ���������������������
select t_name,t_birthday
from Teacher
where t_birthday > '1960-12-31'
order by t_birthday asc   --asc��Ҫ�ɲ�Ҫ��Ĭ������

--MY.1��ѯ��ÿ��ѧ����ѡ���������Լ�ѧ����ѧ�ţ�����
select Choice.s_no,s_name,count (distinct course_no) as ѡ������
from Student,Choice
where Student.s_no=Choice.s_no
group by Choice.s_no,s_name


--MY.2��ѯѧ�ִ���2�ֵĿγ̵�ƽ���ɼ�,��ʾ���γ̺š��γ�����ƽ���ɼ����γ�ѧ��
select Course.course_no,Course.course_name,Course.course_score,avg(score) as ƽ���ɼ�
from Course,Choice
where Course.course_no=Choice.course_no and Course.course_score > 2
group by Course.course_no,Course.course_name,Course.course_score

--MY.3��ѯÿ����ʦ�����ڵĿεĽ�ʦ�š��κš��������γ�ѧ��
select Teaching.t_no,Course.course_no,Course.course_name,Course.course_score
from Course,Teaching
where Course.course_no=Teaching.course_no
group by Teaching.t_no,Course.course_no,Course.course_name,Course.course_score

--MY.4��ѯѡ����01002�γ̵�ѧ����������ƽ���ɼ������ս������У�
select Student.s_name,avg(score) as ƽ���ɼ�
from Student,Choice
where Student.s_no=Choice.s_no --and Choice.course_no=01002
group by Choice.course_no,Student.s_name
having Choice.course_no=01002
order by ƽ���ɼ� desc

--MY.5��ѯ�����ϵ���༶��ƽ���ɼ����༶�ţ��Լ�ƽ���ɼ�
select Student.class_no,avg(score) as ƽ���ɼ�
from Student,Choice
where Student .s_no=Choice.s_no
group by Student.class_no
