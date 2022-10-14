---------------------테이블 제거
DROP TABLE MEMBER cascade constraints;
DROP TABLE NOTICE cascade constraints;
DROP TABLE BREPORT cascade constraints;
DROP TABLE STICKER cascade constraints;
DROP TABLE GALLERY cascade constraints;
DROP TABLE MYCALENDAR cascade constraints;
---------------------시퀀스 제거
DROP SEQUENCE notice_seq;
DROP SEQUENCE bug_seq;
DROP SEQUENCE gallery_seq;
DROP SEQUENCE sticker_seq;
---------------------시퀀스 생성
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

COMMENT ON COLUMN "MEMBER"."USERID" IS '유저아이디';
COMMENT ON COLUMN "MEMBER"."USERPASSWORD" IS '비밀번호';
COMMENT ON COLUMN "MEMBER"."USEREMAIL" IS '이메일';
COMMENT ON COLUMN "MEMBER"."USERNAME" IS '유저이름';
COMMENT ON COLUMN "MEMBER"."USERGENDER" IS '성별';
COMMENT ON COLUMN "MEMBER"."USERADMIN" IS '관리자여부';
COMMENT ON COLUMN "MEMBER"."USERLOGINOK" IS '로그인가능여부';


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

COMMENT ON COLUMN "NOTICE"."NOTICE_NO" IS '공지번호';
COMMENT ON COLUMN "NOTICE"."USERID" IS '유저아이디';
COMMENT ON COLUMN "NOTICE"."NOTICE_TITLE" IS '공지제목';
COMMENT ON COLUMN "NOTICE"."NOTICE_DATE" IS '등록날짜';
COMMENT ON COLUMN "NOTICE"."NOTICE_CONTENT" IS '공지내용';
COMMENT ON COLUMN "NOTICE"."NOTICE_READCOUNT" IS '조회수';
COMMENT ON COLUMN "NOTICE"."NOTICE_UPFILE" IS '첨부파일';
COMMENT ON COLUMN "NOTICE"."NOTICE_REFILE" IS '첨부파일수정';
COMMENT ON COLUMN NOTICE.IMPORTANCE IS '중요도';

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

COMMENT ON COLUMN "BREPORT"."B_NO" IS '글 번호';
COMMENT ON COLUMN "BREPORT"."USERID" IS '유저아이디';
COMMENT ON COLUMN "BREPORT"."B_TITLE" IS '글 제목';
COMMENT ON COLUMN "BREPORT"."B_DATE" IS '등록날짜';
COMMENT ON COLUMN "BREPORT"."B_CONTENT" IS '글 내용';
COMMENT ON COLUMN "BREPORT"."B_READCOUNT" IS '조회수';
COMMENT ON COLUMN "BREPORT"."B_UPFILE" IS '첨부파일';
COMMENT ON COLUMN "BREPORT"."B_REFILE" IS '첨부파일수정';
COMMENT ON COLUMN "BREPORT"."B_LEV" IS '답글단계';
COMMENT ON COLUMN "BREPORT"."B_REF" IS '원글번호';  -- 원글번호
COMMENT ON COLUMN "BREPORT"."B_REPLY_REF" IS '참조답글번호';  -- 원글 : 0, 원글의 답글 : 자기번호, 답글의 답글 : 참조답글번호
COMMENT ON COLUMN "BREPORT"."B_REPLY_SEQ" IS '답글순번'; -- 원글 : 0, 같은 원글의 답글일 때 : 1 ....... 순차처리

CREATE TABLE STICKER(
	SNUM	number	NOT NULL,
	USERID	varchar2(20)		NOT NULL,
	S_ORI_NAME			varchar2(30)		NULL,
    S_RENAME			varchar2(30)		NULL,
    S_DATE			date	DEFAULT sysdate	NOT NULL,
    CATEGORY		varchar2(4) not null
);

COMMENT ON COLUMN "STICKER"."SNUM" IS '스티커등록번호';
COMMENT ON COLUMN "STICKER"."USERID" IS '유저아이디';
COMMENT ON COLUMN "STICKER"."S_ORI_NAME" IS '원본파일명';
COMMENT ON COLUMN "STICKER"."S_RENAME" IS '바뀐파일명';
COMMENT ON COLUMN "STICKER"."S_DATE" IS '스티커등록날짜';
COMMENT ON COLUMN "STICKER"."CATEGORY" IS '스티커카테고리';

CREATE TABLE GALLERY (
    IMG_NUM            number             NOT NULL,
	USERID	                varchar2(20)		NOT NULL,
    IMG_ORI_NAME      	varchar2(100)		NULL,
	IMG_RENAME	            varchar2(30)		NULL,
    IMAGE_DATE	    date	DEFAULT sysdate	NOT NULL
);

COMMENT ON COLUMN "GALLERY"."IMG_NUM" IS '이미지등록번호';
COMMENT ON COLUMN "GALLERY"."IMG_ORI_NAME" IS '원본파일명';
COMMENT ON COLUMN "GALLERY"."IMG_RENAME" IS '바뀐파일명';
COMMENT ON COLUMN "GALLERY"."USERID" IS '유저아이디';
COMMENT ON COLUMN "GALLERY"."IMAGE_DATE" IS '등록날짜';


CREATE TABLE MYCALENDAR (
	CALENDAR_DATE   	date		NOT NULL,
	USERID	                varchar2(20)		NOT NULL,
	FILENAME      	varchar2(30)		NULL,
	CALENDAR_CONTENT	varchar2(100)		NOT NULL
);

COMMENT ON COLUMN "MYCALENDAR"."CALENDAR_DATE" IS '등록날짜';
COMMENT ON COLUMN "MYCALENDAR"."USERID" IS '유저아이디';
COMMENT ON COLUMN "MYCALENDAR"."FILENAME" IS '등록된 이미지 이름';
COMMENT ON COLUMN "MYCALENDAR"."CALENDAR_CONTENT" IS '캘린더 내용';

-------------------------PK 설정
ALTER TABLE MEMBER ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY ("USERID");
ALTER TABLE NOTICE ADD CONSTRAINT "PK_NOTICE" PRIMARY KEY ("NOTICE_NO");
ALTER TABLE BREPORT ADD CONSTRAINT "PK_BREPORT" PRIMARY KEY ("B_NO");
ALTER TABLE STICKER ADD CONSTRAINT "PK_STICKER" PRIMARY KEY ("SNUM");
ALTER TABLE GALLERY ADD CONSTRAINT "PK_GALLERY" PRIMARY KEY ("IMG_NUM");
ALTER TABLE MYCALENDAR ADD CONSTRAINT "PK_CALENDAR" PRIMARY KEY ("CALENDAR_DATE");
-------------------------FK 설정
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

-------------------------------check 조건
ALTER TABLE MEMBER
ADD CONSTRAINT CHK_MEM_LOK CHECK (USERLOGINOK IN ('Y', 'N'));

-------------------------------
update notice
set importance = 1
where importance = 0;
-------------------------------

insert into member values('admin','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'mcg8031@naver.com','관리자','M','Y','Y');
insert into member values('user01','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저1','M','N','Y');
insert into member values('user02','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저2','M','N','Y');
insert into member values('user03','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저3','M','N','Y');
insert into member values('user04','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저4','M','N','Y');
insert into member values('user05','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저1','M','N','Y');
insert into member values('user06','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저2','M','N','Y');
insert into member values('user07','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저3','M','N','Y');
insert into member values('user08','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저4','M','N','Y');
insert into member values('user09','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저1','M','N','Y');
insert into member values('user10','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저2','M','N','Y');
insert into member values('user11','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저3','M','N','Y');
insert into member values('user12','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저4','M','N','Y');
insert into member values('user13','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저1','M','N','Y');
insert into member values('user14','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저2','M','N','Y');
insert into member values('user15','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저3','M','N','Y');
insert into member values('user16','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저4','M','N','Y');
insert into member values('user17','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저1','M','N','Y');
insert into member values('user18','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저2','M','N','Y');
insert into member values('user19','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'tes@naver.com','유저3','M','N','Y');
insert into member values('user20','$2a$10$DS4ynMypwGsVbJip6QwC6ub1JnfgJb9KRZgS/mAh616t91By93FDG', 'test@naver.com','유저4','M','N','Y');


---------------------------------------공지글 2개 등록
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지1번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지2번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지3번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지4번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지5번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지6번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지7번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지8번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지9번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지10번',sysdate,' 공지글입니다.',default,default,default,default);

INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지11번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지12번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지13번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지14번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지15번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지16번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지17번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지18번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지19번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지20번',sysdate,' 공지글입니다.',default,default,default,default);

INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지21번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지22번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지23번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지24번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지25번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지26번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지27번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지28번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지29번',sysdate,' 공지글입니다.',default,default,default,default);
INSERT INTO NOTICE VALUES (notice_seq.nextval, 'admin','공지30번',sysdate,' 공지글입니다.',default,default,default,default);



---------------------------------------버그리포트 2개 등록
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제있어요',sysdate,'문제가있네요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제없어요',sysdate,'문제가없어요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user02','문제있어요',sysdate,'문제가있네요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제없어요',sysdate,'문제가없어요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user03','문제있어요',sysdate,'문제가있네요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제없어요',sysdate,'문제가없어요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제있어요',sysdate,'문제가있네요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제없어요',sysdate,'문제가없어요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제있어요',sysdate,'문제가있네요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user11','문제없어요',sysdate,'문제가없어요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제있어요',sysdate,'문제가있네요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제없어요',sysdate,'문제가없어요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제있어요',sysdate,'문제가있네요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제없어요',sysdate,'문제가없어요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제있어요',sysdate,'문제가있네요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제없어요',sysdate,'문제가없어요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제있어요',sysdate,'문제가있네요',default,default,default,default,default,default,default);
INSERT INTO BREPORT VALUES (bug_seq.nextval, 'user01','문제없어요',sysdate,'문제가없어요',default,default,default,default,default,default,default);

---------------------------------------갤러리 등록
insert into gallery values(gallery_seq.nextval, 'admin', '20221013010634.jpg', '20221013010634.jpg', sysdate);
insert into gallery values(gallery_seq.nextval, 'admin', '20221013031836.jpg', '20221013031836.jpg', sysdate);

---------------------------------------스티커 등록
insert into STICKER values(sticker_seq.nextval, 'admin', 'rabbit_nose.png', 'rabbit_nose.png', sysdate,'nose');

insert into STICKER values(sticker_seq.nextval, 'admin', 'rabbit_right.png', 'rabbit_right.png', sysdate,'rig');

insert into STICKER values(sticker_seq.nextval, 'admin', 'rabbit_left.png', 'rabbit_left.png', sysdate,'lef');

insert into STICKER values(sticker_seq.nextval, 'admin', 'fox_nose.png', 'fox_nose.png', sysdate,'nose');

insert into STICKER values(sticker_seq.nextval, 'admin', 'fox_right.png', 'fox_right.png', sysdate,'rig');

insert into STICKER values(sticker_seq.nextval, 'admin', 'fox_left.png', 'fox_left.png', sysdate,'lef');
commit;
