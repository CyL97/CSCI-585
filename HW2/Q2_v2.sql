--DB Software used livesql.oracle.com

--DROP TABLE Videos;
--DROP TABLE Channels;
--DROP TABLE Users;

--I created a table of users. Here user_ID is the primary key, and each user will have his name.
CREATE TABLE Users
(user_ID VARCHAR(30) NOT NULL,
u_name VARCHAR(30) NOT NULL,
PRIMARY KEY (user_ID));

--I created a table of Channels. Here channel_name is the primary key, and each channel will have a foregin key from Users as their owner.
CREATE TABLE Channels
(channel_name VARCHAR(30) NOT NULL,
user_ID VARCHAR(30) NOT NULL,
PRIMARY KEY (channel_name),
FOREIGN KEY (user_ID) REFERENCES Users(user_ID));

--I used CREATE TABLE to create a table of Videos. Here v_URL is the primary key, and each video will have its own title, name of the channel it belongs to, number of likes, and number of views
CREATE TABLE Videos
(v_URL VARCHAR(50) NOT NULL,
v_title VARCHAR(30) NOT NULL,
channel_name VARCHAR(30) NOT NULL,
v_likes INTEGER NOT NULL,
v_views INTEGER NOT NULL,
PRIMARY KEY (v_URL),
FOREIGN KEY (channel_name) REFERENCES Channels(channel_name));

--I inserted four users
INSERT INTO Users VALUES ('u1', 'Marvel Entertainment Club');
INSERT INTO Users VALUES ('u2', 'DC Best');
INSERT INTO Users VALUES ('u3', 'WOW Marvel Entertainment Best');
INSERT INTO Users VALUES ('u4', 'Batman');

--I inserted six channels
INSERT INTO Channels VALUES ('Iron man', 'u1');
INSERT INTO Channels VALUES ('Spider man', 'u1');
INSERT INTO Channels VALUES ('Collection', 'u3');
INSERT INTO Channels VALUES ('DC Universe', 'u2');
INSERT INTO Channels VALUES ('Newest', 'u3');
INSERT INTO Channels VALUES ('BATMAN', 'u4');

--I inserted ten videos, some of them will have the same channel name
INSERT INTO Videos VALUES ('youtube.com/watch?v=kQb0DJZLhRM', 'A', 'Iron man', 10, 256);
INSERT INTO Videos VALUES ('youtube.com/watch?v=CajjpdHYneM', 'L', 'Spider man', 200, 255);
INSERT INTO Videos VALUES ('youtube.com/watch?v=ZYV5X2rq-F0', 'D', 'DC Universe', 0, 10);
INSERT INTO Videos VALUES ('youtube.com/watch?v=dWzM90u9GUU', 'C', 'Iron man', 1, 1);
INSERT INTO Videos VALUES ('youtube.com/watch?v=feu-aiRVpK4', 'K', 'Spider man', 0, 0);
INSERT INTO Videos VALUES ('youtube.com/watch?v=uXWtG55zDjo', 'B', 'Collection', 10000, 60000);
INSERT INTO Videos VALUES ('youtube.com/watch?v=t3FCDvo07tc', 'Q', 'Newest', 9999, 10000);
INSERT INTO Videos VALUES ('youtube.com/watch?v=rs_t4MoIo-8', 'W', 'BATMAN', 1234, 5678);
INSERT INTO Videos VALUES ('youtube.com/watch?v=2FVfmlnrDW4', 'S', 'DC Universe', 33, 7000);
INSERT INTO Videos VALUES ('youtube.com/watch?v=XAclWd8Yzis', 'Z', 'Collection', 8888, 10000);

--I used subquery in FROM and INNER JOIN to get the result
SELECT v_title as title, channel_name, (case when v_views=0 then 0 else v_likes/v_views end) as ratio
FROM (SELECT v_title, channel_name, v_likes, v_views, u_name
      -- I used INNER JOIN to join three tables into a large one
      FROM((Videos
      INNER JOIN Channels USING (channel_name))
      INNER JOIN Users USING (user_ID)))
--I found the rows meet the u_name contains 'Marvel Entertainment'
WHERE u_name LIKE '%Marvel Entertainment%'
--After got all results, I sorted them with title
ORDER BY title ASC;