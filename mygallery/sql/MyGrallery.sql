---------------------���̺� ����
DROP TABLE MEMBER cascade constraints;
DROP TABLE NOTICE cascade constraints;
DROP TABLE BREPORT cascade constraints;
DROP TABLE STICKER cascade constraints;
DROP TABLE GALLERY cascade constraints;
DROP TABLE MYCALENDAR cascade constraints;
---------------------������ ����
DROP SEQUENCE notice_seq;
DROP SEQUENCE bug_seq;
DROP SEQUENCE gallery_seq;
DROP SEQUENCE sticker_seq;
---------------------������ ����
CREATE SEQUENCE notice_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;

CREATE SEQUENCE bug_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;

CREATE SEQUENCE gallery_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;

CREATE SEQUENCE sticker_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;

CREATE TABLE MEMBER (
	USERID 	            varchar2(20)		        NOT NULL,
	USERPASSWORD	varchar2(100)		        NOT NULL,
	USEREMAIL	        varchar2(100)		        NOT NULL,
	USERNAME	        varchar2(30)		        NOT NULL,
	USERGENDER	    varchar2(1)		            NOT NULL,
	USERADMIN	    char(1)	DEFAULT 'N'	NOT NULL,
	USERLOGINOK	    char(1)	DEFAULT 'Y'	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."USERID" IS '�������̵�';
COMMENT ON COLUMN "MEMBER"."USERPASSWORD" IS '��й�ȣ';
COMMENT ON COLUMN "MEMBER"."USEREMAIL" IS '�̸���';
COMMENT ON COLUMN "MEMBER"."USERNAME" IS '�����̸�';
COMMENT ON COLUMN "MEMBER"."USERGENDER" IS '����';
COMMENT ON COLUMN "MEMBER"."USERADMIN" IS '�����ڿ���';
COMMENT ON COLUMN "MEMBER"."USERLOGINOK" IS '�α��ΰ��ɿ���';


CREATE TABLE NOTICE (
	NOTICE_NO	            number      	NOT NULL,
	USERID                  varchar2(20)		NOT NULL,
	NOTICE_TITLE	        varchar2(100)		NOT NULL,
	NOTICE_DATE	        date	DEFAULT sysdate	NOT NULL,
	NOTICE_CONTENT	varchar2(2000)		NOT NULL,
	NOTICE_READCOUNT	number	DEFAULT 0	NOT NULL,
	NOTICE_UPFILE	        varchar2(100)		NULL,
	NOTICE_REFILE	        varchar2(100)		NULL,
	IMPORTANCE          number default 1
);

COMMENT ON COLUMN "NOTICE"."NOTICE_NO" IS '������ȣ';
COMMENT ON COLUMN "NOTICE"."USERID" IS '�������̵�';
COMMENT ON COLUMN "NOTICE"."NOTICE_TITLE" IS '��������';
COMMENT ON COLUMN "NOTICE"."NOTICE_DATE" IS '��ϳ�¥';
COMMENT ON COLUMN "NOTICE"."NOTICE_CONTENT" IS '��������';
COMMENT ON COLUMN "NOTICE"."NOTICE_READCOUNT" IS '��ȸ��';
COMMENT ON COLUMN "NOTICE"."NOTICE_UPFILE" IS '÷������';
COMMENT ON COLUMN "NOTICE"."NOTICE_REFILE" IS '÷�����ϼ���';
COMMENT ON COLUMN NOTICE.IMPORTANCE IS '�߿䵵';

CREATE TABLE BREPORT (
	B_NO	        number NOT NULL,
	USERID	        varchar2(20)		NOT NULL,
	B_TITLE	    varchar2(100)		NOT NULL,
	B_DATE	    date	DEFAULT sysdate	NOT NULL,
	B_CONTENT	varchar2(2000)		NOT NULL,
	B_READCOUNT	number	DEFAULT 0	NOT NULL,
	B_UPFILE	    varchar2(100)		NULL,
	B_REFILE	    varchar2(100)		NULL,
    B_LEV NUMBER DEFAULT 1,
    B_REF NUMBER,
	B_REPLY_REF	NUMBER,
    B_REPLY_SEQ NUMBER DEFAULT 1
);

COMMENT ON COLUMN "BREPORT"."B_NO" IS '�� ��ȣ';
COMMENT ON COLUMN "BREPORT"."USERID" IS '�������̵�';
COMMENT ON COLUMN "BREPORT"."B_TITLE" IS '�� ����';
COMMENT ON COLUMN "BREPORT"."B_DATE" IS '��ϳ�¥';
COMMENT ON COLUMN "BREPORT"."B_CONTENT" IS '�� ����';
COMMENT ON COLUMN "BREPORT"."B_READCOUNT" IS '��ȸ��';
COMMENT ON COLUMN "BREPORT"."B_UPFILE" IS '÷������';
COMMENT ON COLUMN "BREPORT"."B_REFILE" IS '÷�����ϼ���';
COMMENT ON COLUMN "BREPORT"."B_LEV" IS '��۴ܰ�';
COMMENT ON COLUMN "BREPORT"."B_REF" IS '���۹�ȣ';  -- ���۹�ȣ
COMMENT ON COLUMN "BREPORT"."B_REPLY_REF" IS '������۹�ȣ';  -- ���� : 0, ������ ��� : �ڱ��ȣ, ����� ��� : ������۹�ȣ
COMMENT ON COLUMN "BREPORT"."B_REPLY_SEQ" IS '��ۼ���'; -- ���� : 0, ���� ������ ����� �� : 1 ....... ����ó��

CREATE TABLE STICKER(
	SNUM	number	NOT NULL,
	USERID	varchar2(20)		NOT NULL,
	S_ORI_NAME			varchar2(30)		NULL,
    S_RENAME			varchar2(30)		NULL,
    S_DATE			date	DEFAULT sysdate	NOT NULL,
    CATEGORY		varchar2(4) not null
);

COMMENT ON COLUMN "STICKER"."SNUM" IS '��ƼĿ��Ϲ�ȣ';
COMMENT ON COLUMN "STICKER"."USERID" IS '�������̵�';
COMMENT ON COLUMN "STICKER"."S_ORI_NAME" IS '�������ϸ�';
COMMENT ON COLUMN "STICKER"."S_RENAME" IS '�ٲ����ϸ�';
COMMENT ON COLUMN "STICKER"."S_DATE" IS '��ƼĿ��ϳ�¥';
COMMENT ON COLUMN "STICKER"."CATEGORY" IS '��ƼĿī�װ�';

CREATE TABLE GALLERY (
    IMG_NUM            number             NOT NULL,
	USERID	                varchar2(20)		NOT NULL,
    IMG_ORI_NAME      	varchar2(100)		NULL,
	IMG_RENAME	            varchar2(30)		NULL,
    IMAGE_DATE	    date	DEFAULT sysdate	NOT NULL
);

COMMENT ON COLUMN "GALLERY"."IMG_NUM" IS '�̹�����Ϲ�ȣ';
COMMENT ON COLUMN "GALLERY"."IMG_ORI_NAME" IS '�������ϸ�';
COMMENT ON COLUMN "GALLERY"."IMG_RENAME" IS '�ٲ����ϸ�';
COMMENT ON COLUMN "GALLERY"."USERID" IS '�������̵�';
COMMENT ON COLUMN "GALLERY"."IMAGE_DATE" IS '��ϳ�¥';


CREATE TABLE MYCALENDAR (
	CALENDAR_DATE   	date		NOT NULL,
	USERID	                varchar2(20)		NOT NULL,
	FILENAME      	varchar2(30)		NULL,
	CALENDAR_CONTENT	varchar2(100)		NOT NULL
);

COMMENT ON COLUMN "MYCALENDAR"."CALENDAR_DATE" IS '��ϳ�¥';
COMMENT ON COLUMN "MYCALENDAR"."USERID" IS '�������̵�';
COMMENT ON COLUMN "MYCALENDAR"."FILENAME" IS '��ϵ� �̹��� �̸�';
COMMENT ON COLUMN "MYCALENDAR"."CALENDAR_CONTENT" IS 'Ķ���� ����';

-------------------------PK ����
ALTER TABLE MEMBER ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY ("USERID");
ALTER TABLE NOTICE ADD CONSTRAINT "PK_NOTICE" PRIMARY KEY ("NOTICE_NO");
ALTER TABLE BREPORT ADD CONSTRAINT "PK_BREPORT" PRIMARY KEY ("B_NO");
ALTER TABLE STICKER ADD CONSTRAINT "PK_STICKER" PRIMARY KEY ("SNUM");
ALTER TABLE GALLERY ADD CONSTRAINT "PK_GALLERY" PRIMARY KEY ("IMG_NUM");
ALTER TABLE MYCALENDAR ADD CONSTRAINT "PK_CALENDAR" PRIMARY KEY ("CALENDAR_DATE");
-------------------------FK ����
ALTER TABLE NOTICE ADD CONSTRAINT "FK_MEMBER_TO_NOTICE_1" FOREIGN KEY ("USERID")
REFERENCES MEMBER (	"USERID");
ALTER TABLE BREPORT ADD CONSTRAINT "FK_MEMBER_TO_BREPORT_1" FOREIGN KEY ("USERID")
REFERENCES MEMBER ("USERID");
ALTER TABLE STICKER ADD CONSTRAINT "FK_STICKER" FOREIGN KEY ("USERID")
REFERENCES MEMBER ("USERID");
ALTER TABLE GALLERY ADD CONSTRAINT "FK_MEMBER_TO_CALLERY_MEMBER_1" FOREIGN KEY ("USERID")
REFERENCES MEMBER ("USERID");
ALTER TABLE MYCALENDAR ADD CONSTRAINT "FK_MEMBER_TO_CALENDAR_1" FOREIGN KEY ("USERID")
REFERENCES MEMBER (	"USERID");

-------------------------------check ����
ALTER TABLE MEMBER
ADD CONSTRAINT CHK_MEM_LOK CHECK (USERLOGINOK IN ('Y', 'N'));

-------------------------------
update notice
set importance = 1
where importance = 0;
-------------------------------

insert into member values('admin','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'mcg8031@naver.com','������','M','Y','Y');
insert into member values('user01','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����1','M','N','Y');
insert into member values('user02','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����2','M','N','Y');
insert into member values('user03','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����3','M','N','Y');
insert into member values('user04','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����4','M','N','Y');
insert into member values('user05','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����1','M','N','Y');
insert into member values('user06','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����2','M','N','Y');
insert into member values('user07','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����3','M','N','Y');
insert into member values('user08','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����4','M','N','Y');
insert into member values('user09','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����1','M','N','Y');
insert into member values('user10','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����2','M','N','Y');
insert into member values('user11','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����3','M','N','Y');
insert into member values('user12','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����4','M','N','Y');
insert into member values('user13','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����1','M','N','Y');
insert into member values('user14','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����2','M','N','Y');
insert into member values('user15','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����3','M','N','Y');
insert into member values('user16','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����4','M','N','Y');
insert into member values('user17','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����1','M','N','Y');
insert into member values('user18','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����2','M','N','Y');
insert into member values('user19','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','����3','M','N','Y');
insert into member values('user20','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','����4','M','N','Y');


---------------------------------------������ 2�� ���
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����1��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����2��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����3��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����4��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����5��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����6��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����7��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����8��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����9��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����10��',sysdate,' �������Դϴ�.',default,default,default,default);

INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����11��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����12��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����13��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����14��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����15��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����16��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����17��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����18��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����19��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����20��',sysdate,' �������Դϴ�.',default,default,default,default);

INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����21��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����22��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����23��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����24��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����25��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����26��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����27��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����28��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����29��',sysdate,' �������Դϴ�.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','����30��',sysdate,' �������Դϴ�.',default,default,default,default);



---------------------------------------���׸���Ʈ 2�� ���
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','�����־��',sysdate,'�������ֳ׿�',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','���������',sysdate,'�����������',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user02','�����־��',sysdate,'�������ֳ׿�',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','���������',sysdate,'�����������',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user03','�����־��',sysdate,'�������ֳ׿�',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','���������',sysdate,'�����������',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','�����־��',sysdate,'�������ֳ׿�',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','���������',sysdate,'�����������',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','�����־��',sysdate,'�������ֳ׿�',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user11','���������',sysdate,'�����������',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','�����־��',sysdate,'�������ֳ׿�',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','���������',sysdate,'�����������',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','�����־��',sysdate,'�������ֳ׿�',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','���������',sysdate,'�����������',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','�����־��',sysdate,'�������ֳ׿�',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','���������',sysdate,'�����������',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','�����־��',sysdate,'�������ֳ׿�',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','���������',sysdate,'�����������',default,default,default,default,default,default,default);

---------------------------------------������ ���
insert into gallery values(gallery_seq.nextval, 'admin', '20221013010634.jpg', '20221013010634.jpg', sysdate);
insert into gallery values(gallery_seq.nextval, 'admin', '20221013031836.jpg', '20221013031836.jpg', sysdate);

---------------------------------------��ƼĿ ���
insert into STICKER values(sticker_seq.nextval, 'admin', 'rabbit_nose.png', 'rabbit_nose.png', sysdate,'nose');

insert into STICKER values(sticker_seq.nextval, 'admin', 'rabbit_right.png', 'rabbit_right.png', sysdate,'rig');

insert into STICKER values(sticker_seq.nextval, 'admin', 'rabbit_left.png', 'rabbit_left.png', sysdate,'lef');

insert into STICKER values(sticker_seq.nextval, 'admin', 'fox_nose.png', 'fox_nose.png', sysdate,'nose');

insert into STICKER values(sticker_seq.nextval, 'admin', 'fox_right.png', 'fox_right.png', sysdate,'rig');

insert into STICKER values(sticker_seq.nextval, 'admin', 'fox_left.png', 'fox_left.png', sysdate,'lef');
commit;
