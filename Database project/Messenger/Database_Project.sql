--------------------------Drop all the tables--------------------------------
DROP TABLE table_message;
DROP TABLE table_relation_user_collection;
DROP TABLE table_collection;
DROP TABLE table_friendship;
DROP TABLE table_user;


-------------------------Create all the tables-------------------------------
CREATE TABLE table_user (
	user_id		number(4),
	user_name	varchar(10) NOT NULL,
	pass		varchar(10),
	date_of_birth	date,
	gender		varchar(6) DEFAULT 'male',
	date_added      date,
	PRIMARY KEY (user_id)
);


CREATE TABLE table_friendship (
	user1_id	number(4),
	user2_id	number(4),
	accepted	varchar(1),
	FOREIGN KEY (user1_id)	REFERENCES table_user(user_id),
	FOREIGN KEY (user2_id)  REFERENCES table_user(user_id)
);


CREATE TABLE table_collection (
	collection_id	number(4),
	admin_id	number(4),
	PRIMARY KEY (collection_id),
	FOREIGN KEY (admin_id) REFERENCES table_user(user_id)
);


CREATE TABLE table_relation_user_collection (
	collection_id	number(4),
	user_id		number(4),
	FOREIGN KEY (collection_id) REFERENCES table_collection(collection_id) ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES table_user(user_id) ON DELETE CASCADE
);


CREATE TABLE table_message (
	text	varchar(50),
	collection_id	number(4),
	sent_time	date,
	sender_id	number(4),
	FOREIGN KEY (collection_id) REFERENCES table_collection(collection_id) ON DELETE CASCADE
	--FOREIGN KEY (sender_id) REFERENCES table_user(user_id) ON DELETE CASCADE
);

-------------------------------------------FOREIGN KEY OUTSIDE TABLE----------------------------------

ALTER TABLE table_message ADD CONSTRAINT collection_id_foreign
	FOREIGN KEY (sender_id) REFERENCES table_user(user_id) ON DELETE CASCADE;





----------------------------------------Describe the tables------------------------
DESCRIBE table_user;
DESCRIBE table_friendship;
DESCRIBE table_relation_user_collection;
DESCRIBE table_collection;
DESCRIBE table_message;





-----------------------ALTER TABLE-----------------------------
ALTER TABLE table_user
	ADD age number(2) CHECK (age > 0 AND age < 150);
ALTER TABLE table_user
	MODIFY age number(3);
ALTER TABLE table_user
	RENAME COLUMN age to user_age;
DESCRIBE table_user;
ALTER TABLE table_user
	DROP COLUMN user_age;



---------------------------------------------------------------------Create users------------------------------------------------------------------------------
insert into table_user(user_id, user_name,pass, date_of_birth, gender)
	values (1000, 'John','pass', '16-JUN-93', 'Male');
insert into table_user(user_id, user_name,pass,  date_of_birth, gender)
	values (1001, 'Paul','pass', '12-FEB-93', 'Male');
insert into table_user(user_id, user_name,pass,  date_of_birth, gender)
	values (1002, 'Paige','pass', '22-OCT-93', 'Female');
insert into table_user(user_id, user_name,pass,  date_of_birth, gender)
	values (1003, 'Allie','pass', '25-JUL-93', 'Female');
insert into table_user(user_id, user_name,pass,  date_of_birth, gender)
	values (1004, 'Leo','pass', '21-JUL-93', 'Male');





----------------------------------------------------------------------Make friendships------------------------------------------------------------------------

---------------John & Leo are friends--------------------
insert into table_friendship(user1_id, user2_id, accepted)
	values (1000, 1004, 'Y');

---------------John & Allie are friends---------------------
insert into table_friendship(user1_id, user2_id, accepted)
	values (1000, 1003, 'Y');

---------------Paul & Paige are friends-------------------
insert into table_friendship(user1_id, user2_id, accepted)
	values (1001, 1002, 'Y');

---------------Paige & Allie are friends---------------------
insert into table_friendship(user1_id, user2_id, accepted)
	values (1002, 1003, 'Y');

---------------Paul & Leo are pending--------------------
insert into table_friendship(user1_id, user2_id, accepted)
	values (1001, 1004, 'N');




-----------------------------------------------------------------------Message Collections--------------------------------------------------------------------------

------------------------------------------------------------------
--A conversation started by John--
insert into table_collection(collection_id, admin_id)
	values (1000, 1000);

--A conversation started at Leo--
insert into table_collection(collection_id, admin_id)
	values (1001, 1004);
------------------------------------------------------------------


------------------------------------------------------------------
--A conversation started by Allie--
insert into table_collection(collection_id, admin_id)
	values (1002, 1003);

--A conversation started at Paige--
insert into table_collection(collection_id, admin_id)
	values (1003, 1002);
-------------------------------------------------------------------


--------------------------------------------------------------------
--A conversation started by Paul--
insert into table_collection(collection_id, admin_id)
	values (1004, 1001);

--A conversation started at Paige--
insert into table_collection(collection_id, admin_id)
	values (1005, 1002);

--A conversation started at Leo--
insert into table_collection(collection_id, admin_id)
	values (1006, 1004);
--------------------------------------------------------------------





-----------------------------------------------------------Conversation towards------------------------------------------------------


--John is talking with Leo--
--------------------------------------------------------------------
insert into table_relation_user_collection(collection_id, user_id)
	values (1000,1004);

--Leo is talking with John--
----------------------------------------------------------------------
insert into table_relation_user_collection(collection_id, user_id)
	values (1001,1000);

--Allie is talking with Paige--
---------------------------------------------------------------------
insert into table_relation_user_collection(collection_id, user_id)
	values (1002,1002);

--Paige is talking with Allie--
----------------------------------------------------------------------
insert into table_relation_user_collection(collection_id, user_id)
	values (1003,1003);

--Paul is talking with Paige--
----------------------------------------------------------------------
insert into table_relation_user_collection(collection_id, user_id)
	values (1004,1002);

--Paige is talking with Paul--
----------------------------------------------------------------------
insert into table_relation_user_collection(collection_id, user_id)
	values (1005,1001);

--Paul is talking with Leo--
----------------------------------------------------------------------
insert into table_relation_user_collection(collection_id, user_id)
	values (1004,1004);

--Leo is talking with Paul--
----------------------------------------------------------------------
insert into table_relation_user_collection(collection_id, user_id)
	values (1006,1001);




-------------------------------------------------------------------------Messages------------------------------------------------------------------------


--Messages of John and Leo--------------------------------------------------------
insert into table_message(text, collection_id, sent_time,sender_id)
	values('Hello Leo!', 1000, sysdate, 1000);
insert into table_message(text, collection_id, sent_time,sender_id)
	values('Hello Leo!', 1001, sysdate, 1000);
insert into table_message(text, collection_id, sent_time,sender_id)
	values('Hi John!', 1000, sysdate, 1004);
insert into table_message(text, collection_id, sent_time,sender_id)
	values('Hi John!', 1001, sysdate, 1004);


--Messages of Paige and Allie--------------------------------------------------------
insert into table_message(text, collection_id, sent_time,sender_id)
	values('Hello Allie!', 1002, sysdate, 1002);
insert into table_message(text, collection_id, sent_time,sender_id)
	values('Hello Allie!', 1003, sysdate, 1002);
insert into table_message(text, collection_id, sent_time,sender_id)
	values('Hi Paige!', 1002, sysdate, 1003);
insert into table_message(text, collection_id, sent_time,sender_id)
	values('Hi Paige!', 1003, sysdate, 1003);



-----------------------------------------Update TABLE-----------------------------------
UPDATE table_message SET sent_time='14-JUN-15' WHERE collection_id = 1002 AND sender_id = 1002;
UPDATE table_message SET sent_time='14-JUN-15' WHERE collection_id = 1003 AND sender_id = 1002;
UPDATE table_message SET sent_time='14-JUN-15' WHERE collection_id = 1002 AND sender_id = 1003;
UPDATE table_message SET sent_time='14-JUN-15' WHERE collection_id = 1003 AND sender_id = 1003;



------------------------------------------------------------------------Show table items-------------------------------------------------------------------------


----------------------------------------------------------------------SELECT------------------------------------------------------------------


-----Show all users (General SELECT)---------
SELECT * from table_user;


------------------Show all threads (WHERE CONDITION)--------
SELECT t.collection_id, u.user_name AS "Started By" from table_collection t, table_user u where t.admin_id = u.user_id;




--------------------------------------------------------------------------JOINS--------------------------------------------------------------



-----------------Show all friendships (JOIN with NESTED QUERIES and RENAME of COLUMN)--------------
SET LINES 512
SELECT DISTINCT usr.user_name AS "Person", u.user_name AS "Is Friend Of", frnd.accepted AS "Accepted" from ((table_friendship frnd join table_user usr ON frnd.user1_id = usr.user_id) join table_user u ON user2_id = u.user_id); 


----Show all conversations connection (NATURAL JOIN with NESTED QUERIES) ----
SELECT collection_id, u2.user_name AS "Person spoken", t3.user_name AS "Spoken to" from (table_relation_user_collection t1 natural join table_collection t2 natural join table_user t3) join table_user u2 ON t2.admin_id = u2.user_id ORDER BY u2.user_name;


----Show messages (CROSS JOIN)--
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message CROSS JOIN table_user u where sender_id = u.user_id AND collection_id = 1000;
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message CROSS JOIN table_user u where sender_id = u.user_id AND collection_id = 1002;


--------------------NON EQUI JOIN with EXTRACT---------------------
SELECT text AS "Message", sent_time AS "Sent Time" FROM table_message t1 JOIN table_user t2 ON (t1.sender_id = t2.user_id AND EXTRACT(YEAR FROM t1.sent_time) < 2020);


-------------------SELF JOIN--------------------------------
SELECT * FROM table_message t1 JOIN table_message t2 ON t1.sender_id = t2.sender_id;


--------------------LEFT OUTER JOIN-------------------
SELECT text AS "Message",  sent_time AS "Sent Time", admin_id AS "FROM ID"  FROM table_message t1 LEFT OUTER JOIN table_collection t2 ON t1.collection_id = t2.collection_id; 

--------------------RIGHT OUTER JOIN-------------------
SELECT text AS "Message",  sent_time AS "Sent Time", admin_id AS "FROM ID"  FROM table_message t1 RIGHT OUTER JOIN table_collection t2 ON t1.collection_id = t2.collection_id; 

--------------------FULL OUTER JOIN-------------------
SELECT text AS "Message", sent_time AS "Sent Time", admin_id AS "FROM ID" FROM table_message t1 FULL OUTER JOIN table_collection t2 ON t1.collection_id = t2.collection_id; 



---------------------------------------------------------------------MORE ON SELECT----------------------------------------------------------------



----------------------LIKE---------------------------
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message, table_user u where sender_id = u.user_id AND collection_id = 1001 AND text LIKE '%Hi%';




-----------------------ORDER BY---------------------
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message, table_user u where sender_id = u.user_id ORDER BY (sent_time);
	



-----------------------AGGREGATE FUNCTION COUNT, GROUP BY with HAVING------------------
SELECT COUNT(text) AS "Number of Messages Sent", user_name AS "From" from table_message, table_user u where sender_id = u.user_id GROUP BY (user_name) HAVING COUNT(text) < 100;




----------------------UNION----------------------
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message, table_user u where sender_id = u.user_id AND collection_id = 1000
UNION ALL
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message, table_user u where sender_id = u.user_id AND collection_id = 1002;



---------------------INTERSECT--------------------
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message, table_user u where sender_id = u.user_id AND collection_id = 1000
INTERSECT
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message, table_user u where sender_id = u.user_id AND collection_id = 1002;



---------------------UNION + MINUS-------------------
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message, table_user u where sender_id = u.user_id AND collection_id = 1000
UNION ALL
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message, table_user u where sender_id = u.user_id AND collection_id = 1002
MINUS
SELECT text AS "Message", user_name AS "From", sent_time AS "Sent Time" from table_message, table_user u where sender_id = u.user_id AND collection_id = 1002;



--------------------------------------------------------PL/SQL----------------------------------------------------



-----------------------------------------------------CURSOR---------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
     CURSOR user_cur IS SELECT user_name, user_id FROM table_user;
     name_row user_cur%ROWTYPE;
BEGIN
DBMS_OUTPUT.PUT_LINE('Current users : ');
OPEN user_cur;
      LOOP
        FETCH user_cur INTO name_row;
	DBMS_OUTPUT.PUT_LINE('User : ' || name_row.user_name);
        EXIT WHEN user_cur%ROWCOUNT > 4;
      END LOOP;
CLOSE user_cur;  

END;
/


---------------------------------------------------LOOP---------------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
   counter    NUMBER(2) := 0;
   var_user_name       table_user.user_name%TYPE;
   var_date_of_birth    table_user.date_of_birth%TYPE;
  
BEGIN

   WHILE counter <= 4 
   LOOP

      SELECT user_name, date_of_birth 
      INTO var_user_name, var_date_of_birth
      FROM table_user
      WHERE
      user_id = 1000+counter;

      DBMS_OUTPUT.PUT_LINE ('User number :' || counter);
      DBMS_OUTPUT.PUT_LINE ('User name : ' || var_user_name || ' - date of birth : ' || var_date_of_birth);
      DBMS_OUTPUT.PUT_LINE ('------------------------------------------------------------------------------');

      counter := counter + 1 ;

   END LOOP;

   EXCEPTION
      WHEN others THEN
         DBMS_OUTPUT.PUT_LINE (SQLERRM);
END;
/


--------------------------------------------------------PROCEDURE----------------------------------------------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE print_user_name(u_id table_user.user_id%type) IS 
   u_name table_user.user_name%type;
BEGIN
    SELECT user_name INTO u_name
    FROM table_user
    WHERE user_id = u_id;
    DBMS_OUTPUT.PUT_LINE('User name: ' || u_name || ' for user_id=' || u_id);
END;
/
SHOW ERRORS;




SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE add_user(u_id table_user.user_id%type, u_name table_user.user_name%type,u_pass table_user.pass%type, u_gender table_user.gender%type,u_dob table_user.date_of_birth%type) IS 
BEGIN
    INSERT INTO table_user VALUES (u_id, u_name,u_pass, u_dob, u_gender, NULL);
    DBMS_OUTPUT.PUT_LINE('User added successfully');
END;
/
SHOW ERRORS;




-------------------------------------------------------PROCEDURE CALL-----------------------------------------------------
BEGIN
	print_user_name(1000);
END;
/





-------------------------------------------------------FUNCTION------------------------------------------------------------
CREATE OR REPLACE FUNCTION number_of_users RETURN NUMBER IS
  user_count number(5);
BEGIN
  SELECT count(user_id) INTO user_count
  FROM table_user;
  RETURN user_count;
END;
/




CREATE OR REPLACE FUNCTION get_user_year (u_id table_user.user_id%type) RETURN NUMBER IS
	u_year NUMBER(4);
BEGIN
 	SELECT to_number(EXTRACT(YEAR FROM date_of_birth)) INTO u_year FROM table_user WHERE user_id = u_id;
	RETURN u_year;
END;
/





-------------------------------------------------------FUNCTION CALL---------------------------------------------------
BEGIN
	dbms_output.put_line('Number of users : ' || number_of_users);
	dbms_output.put_line('User John-s date of birth - year : ' ||  get_user_year(1000));
END;
/






-------------------------------------------------------TRIGGER--------------------------------------------------------
CREATE OR REPLACE TRIGGER add_date_automatic BEFORE INSERT OR UPDATE ON table_user
FOR EACH ROW
DECLARE
BEGIN
  IF :new.date_added IS NULL THEN
	:new.date_added := sysdate;
END IF;
END;
/
SHOW ERRORS;




--------------------------------------------------------COMMIT-----------------------------------------------------
COMMIT;





--------------------------------------------------------USE OF TRIGGER-----------------------------------------------
BEGIN
add_user(1005, 'Angelina','password', 'Female', '12-MAY-94'); 
END;
/




--------------------------------------------------------ROLLBACK-----------------------------------------
ROLLBACK;



-------------------------------------------------------SAVEPOINT---------------------------------------------------
BEGIN
add_user(1005, 'Angelina','password', 'Female','12-MAY-94'); 
END;
/

SAVEPOINT P1;

BEGIN
add_user(1006, 'Noris','password', 'Male','12-MAY-94');
END;
/

ROLLBACK TO P1;

ROLLBACK;
---------------------------------------------------------DATE--------------------------------------------------
BEGIN
add_user(1005, 'Angelina','password', 'Female', '12-MAY-94'); 
END;
/

SELECT * FROM table_user WHERE date_added - date_of_birth != 0;

SELECT user_name, ADD_MONTHS(date_of_birth, 12) AS "Actual Date of Birth" FROM table_user WHERE date_Added - date_of_birth != 0;

SELECT GREATEST (date_added, date_of_birth) FROM table_user WHERE date_added - date_of_birth != 0;
