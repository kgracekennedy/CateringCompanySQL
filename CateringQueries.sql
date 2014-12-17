/*Lab 10
Kathleen Grace Kennedy
*/

/*Problem 1:
List the last name and first name of all staff supervised 
by Meredith Yolanda who make more than $15 per hour
*/

/*NOTES
select * 
from mr_staff
where fname='Meredith';
*/
/*So we know that the supervisor variable is a social security number*/


select fname,lname
from mr_staff
where hourly_rate>15 and supervisor in
(select ssn
from mr_staff
where fname='Meredith' and lname='Yolenda');

/*Problem 1 OUTPUT
Ursula	Taylor
F.D.	Well
*/

/*Problem 2:
List the location, date and time of all events that had 
Beef au Jous as the main course (use the description from the maincourse)
*/

/*NOTES
"Au" should be "au"
*/
/*
*/


select event_date,event_time,location
from mr_event inner join mr_menu 
on mr_event.MENU_ID=mr_menu.MENU_ID
inner join mr_maincourse 
on mr_menu.MAINCOURSE_ID=mr_maincourse.MAINCOURSE_ID
where description='Beef au Jous';

/*Problem 2 OUTPUT
18-JAN-05	07:00 PM	Sportsman Club
15-FEB-99	06:00 PM	Worcester Lions Club
*/


/*Problem 3:
List the description of all main courses 
that include a baked potato and a tossed salad.
*/

/*NOTES

*/
/*or mr_dish.description='Tossed Salad'
mr_maincourse.description
*/

select description 
from mr_maincourse
where MAINCOURSE_ID in
(select maincourse_id 
from mr_course_item inner join mr_dish
on mr_course_item.dish_id=mr_dish.DISH_ID
where description='Tossed Salad' and mr_course_item.MAINCOURSE_ID in
(select mr_course_item.maincourse_id 
from mr_course_item inner join mr_dish
on mr_course_item.dish_id=mr_dish.DISH_ID
where description='Baked Potato'));



/*Problem 3 OUTPUT
Chicken Picatta with Potato
Beef au Jous
*/

/*Problem 4:
Find all dishes which have never been served
*/

/*NOTES
select distinct menu_id
from mr_event;
select distinct menu_id
from mr_menu;
*/
/*
*/


select dish_id,DESCRIPTION 
from mr_dish
where dish_id not in
(select distinct mr_dish.dish_id
from mr_event inner join mr_menu 
on mr_event.MENU_ID=mr_menu.MENU_ID
inner join mr_maincourse 
on mr_menu.MAINCOURSE_ID=mr_maincourse.MAINCOURSE_ID
inner join mr_course_item
on mr_maincourse.maincourse_id=mr_course_item.maincourse_id
inner join mr_dish
on mr_course_item.dish_id=mr_dish.dish_id);




/*Problem 4 OUTPUT
AC-7	Scalloped Potato
AP-3	Fruit Cup
BF-1	Steak
BF-2	Steak Tips
CX-2	Chicken Cordon Bleu
PA-2	Lasagna
PA-3	Baked Ziti
PA-4	Spaghetti
PA-5	Manicotti
SA-1	Salad Bar
SA-3	Ceaser Salad
SP-2	Chicken Noodle
VG-1	Vegetable Medley
VG-4	Sweet Peas
VM-1	Veggie Stir Fry
BK-1	Omlet
BK-2	French Toast
BK-4	Homefries
BK-5	Sausage
BK-7	Canadian Bacon
*/

/*Extra Credit:  (Extra Credit 10 points) 
The shift field in the staff table indicates either 
1, day shift (available for breakfast or lunch) and 
2, night shift (available for dinner.) 
The start_hour field in the event table indicates the hour 
(in 24 hour format) that an event starts. 
Assume that the day shift is available to work from 7:00 am to 3:00 pm and 
the night shift is available from 3:00 pm to 11:00 pm. 
Management would like a report of which employees worked shifts 
that were not their normal shifts. 
Please write a query to show the employee name, date of the event and hours worked 
(assume that the employee worked the total event time). 
You may need to create a view first. 
Hint: you may wish to perform a union operation.
*/

/*NOTES
First try to select all normal day workers who worked at night
*/
/*
*/

select distinct mr_staff.ssn,fname,lname
from mr_staff inner join mr_event_staff
on mr_staff.ssn=mr_event_staff.ssn
inner join mr_event
on mr_event_staff.event_id=mr_event.event_id
where shift=1 and mr_event.START_HOUR>15
union
select distinct mr_staff.ssn,mr_staff.fname,mr_staff.lname
from mr_staff inner join mr_event_staff
on mr_staff.ssn=mr_event_staff.ssn
inner join mr_event
on mr_event_staff.event_id=mr_event.event_id
where shift=2 and mr_event.START_HOUR + duration<15;


/*Extra Credit OUTPUT
013-23-2121	Wilma	Smith
014-21-2331	Warren	Williams
014-54-4412	Ili	Lo
015-22-1212	Earl	Roth
374-32-2121	Ursula	Taylor
986-21-2721	F.D.	Well
*/