USE [university_management]
GO

insert into COLLEGE (college_id, city, address, state, college_name) values ('C1', 'Lees Summit', '20 Spenser Point', 'Missouri', 'Khoury');
insert into COLLEGE (college_id, city, address, state, college_name) values ('C2', 'Grand Rapids', '9 Erie Court', 'Michigan', 'College of Engineering');
insert into COLLEGE (college_id, city, address, state, college_name) values ('C3', 'Santa Barbara', '32284 Manufacturers Center', 'California', 'College of Professional Studies');
insert into COLLEGE (college_id, city, address, state, college_name) values ('C4', 'Ashburn', '571 Schmedeman Way', 'Virginia', 'College of Art and Design');

GO


insert into BUILDING (building_id, building_name, address, college_id) values (1, 'McClure, Schroeder and Lebsack', '1858 Center Lane', 'C4');
insert into BUILDING (building_id, building_name, address, college_id) values (2, 'Luettgen, Blanda and Littel', '13208 Sunfield Hill', 'C4');
insert into BUILDING (building_id, building_name, address, college_id) values (3, 'Bergstrom-White', '5018 Sycamore Plaza', 'C1');
insert into BUILDING (building_id, building_name, address, college_id) values (4, 'Nienow Inc', '6036 Aberg Road', 'C3');
insert into BUILDING (building_id, building_name, address, college_id) values (5, 'Stark Inc', '39 Iowa Center', 'C1');
insert into BUILDING (building_id, building_name, address, college_id) values (6, 'Green-Kirlin', '2 Daystar Place', 'C1');
insert into BUILDING (building_id, building_name, address, college_id) values (7, 'Marks, Abernathy and Rath', '81 4th Lane', 'C1');
insert into BUILDING (building_id, building_name, address, college_id) values (8, 'Hudson-Walsh', '76 Walton Park', 'C2');
insert into BUILDING (building_id, building_name, address, college_id) values (9, 'Rohan-Corwin', '9 Graceland Junction', 'C1');
insert into BUILDING (building_id, building_name, address, college_id) values (10, 'Nitzsche-Paucek', '8321 Hallows Junction', 'C4');

GO
