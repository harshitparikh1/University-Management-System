-- All the primary key and foreign key constraints are included in the DDL. Other constraints are as follows:

ALTER TABLE SCHEDULES ADD CONSTRAINT isAvailableChk CHECK (isAvailable in (0, 1));
ALTER TABLE SCHEDULES ADD CONSTRAINT endDateChk check (end_date > start_date)
ALTER TABLE COURSE ADD CONSTRAINT endDateChkCourse check (end_date > start_date);
ALTER TABLE STAFF_DEPT ADD CONSTRAINT endDateChkStaffDept check (end_date > start_date);
