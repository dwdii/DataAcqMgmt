-- 
-- Author: Daniel Dittenhafer
--
-- Created: Oct 14, 2014
--
-- Description: Answers to Week 8 Assignment
--

-- 1. Blog with comments and tags: http://www.hanselman.com/

-- 2. Design the logical database:
-- 
--    See associated ER diagram: https://raw.githubusercontent.com/dwdii/DataAcqMgmt/master/Week8/BlogER.png

-- 3. Implement the physical database

CREATE DATABASE blogdb;

CREATE TABLE tags (
	id serial PRIMARY KEY,
	tagname VARCHAR(128) NOT NULL
);

CREATE TABLE blogpost (
	id serial PRIMARY KEY,
	title VARCHAR(128) NOT NULL,
	content text NOT NULL,
	created timestamp NOT NULL
);

CREATE TABLE blogposttags (
	tagid int NOT NULL,
	blogpostid int NOT NULL,

	PRIMARY KEY(tagid, blogpostid),
	CONSTRAINT blogposttags_tag FOREIGN KEY (tagid) REFERENCES tags(id),
	CONSTRAINT blogposttags_blogpost FOREIGN KEY (blogpostid) REFERENCES blogpost(id)
);


CREATE TABLE comments (
	id serial PRIMARY KEY,
	blogpostid int NOT NULL,
	author VARCHAR(128) NOT NULL,
	comment text NOT NULL,
	created timestamp NOT NULL,

	CONSTRAINT comments_blogpost FOREIGN KEY (blogpostid) REFERENCES blogpost(id)
);

-- 4. Populate the physical database with sample data
INSERT INTO tags (tagname) VALUES ('Africa');
INSERT INTO tags (tagname) VALUES ('Agile');
INSERT INTO tags (tagname) VALUES ('Android');
INSERT INTO tags (tagname) VALUES ('AppFabric');
INSERT INTO tags (tagname) VALUES ('Apple');
INSERT INTO tags (tagname) VALUES ('Arcade');
INSERT INTO tags (tagname) VALUES ('ASP.NET');
INSERT INTO tags (tagname) VALUES ('Musings');
INSERT INTO tags (tagname) VALUES ('Parenting');
INSERT INTO tags (tagname) VALUES ('Z');
INSERT INTO tags (tagname) VALUES ('Data');
INSERT INTO tags (tagname) VALUES ('Open Source');
INSERT INTO tags (tagname) VALUES ('Podcast');

-- Blog Post 1
INSERT INTO blogpost (title, content, created) VALUES ('Roshambo and Rise of Nations', '<P>If you''ve every played Age of Empires or the new Rise of Nations, you''ve probably realized by now that they are just&nbsp;really elaborate examples of <STRONG><A href="http://www.brunching.com/psr.html">Rock-Paper-Scissors</A></STRONG> <EM>(Pikeman beats&nbsp;Knight, Knight beats Footman,&nbsp;Footman beats Pikeman...).&nbsp;</EM></P>
<P>Even though I know this -&nbsp;as a 29 year old man I can intellectualize this - but&nbsp;I still stayed up until midnight last night playing International Roshambo (also known as <A href="http://www.microsoft.com/games/riseofnations/">Rise of Nations</A>).&nbsp;&nbsp;Dammit if it isn''t a fantastic game.&nbsp; I''m not even a big gamer, but the level of detail and thought put into this game is ridiculous.&nbsp; </P>
<P>Of course, I play the <A href="http://www.microsoft.com/games/riseofnations/nations_bantu.asp">Bantu</A>&nbsp;(my wife is <A href="http://www.hanselman.com/Zimbabwe">Zimbabwean Ndebele</A>, a <A href="http://www.cbold.ddl.ish-lyon.cnrs.fr/">Bantu</A> tribe) as they kick the most butt.</P>', '2003-08-19');

INSERT INTO blogposttags (tagid, blogpostid) VALUES (1, 1);
INSERT INTO blogposttags (tagid, blogpostid) VALUES (8, 1);

-- Blog Post 2
INSERT INTO blogpost (title, content, created) VALUES ('A Toy Train for Z', '<p>Here we are at the end of Week 1 of <a href="http://www.hanselman.com/blog/babyTarrives.aspx">Paternity Leave</a>. Baby T is doing very well, having already gained a pound and a half. The doctor was shocked, but this boy can eat. He''s also very expressive. Z is enjoying his baby brother very much and hasn''t shown any jealousy. Yet.</p>  <p><a title="CIMG7810" href="http://www.flickr.com/photos/26275740@N00/2094315219/"><a title="CIMG7805" href="http://www.flickr.com/photos/26275740@N00/2094315163/"><img alt="CIMG7805" src="http://static.flickr.com/2127/2094315163_aab6eb073e_m.jpg" border="0" /><a title="CIMG7807" href="http://www.flickr.com/photos/26275740@N00/2094315187/"><img alt="CIMG7807" src="http://static.flickr.com/2011/2094315187_2866d0c7cf_m.jpg" border="0" /></a></a></a></p>  <p><img alt="CIMG7810" src="http://static.flickr.com/2206/2094315219_2f34d2421d_m.jpg" border="0" /><a title="CIMG7763" href="http://www.flickr.com/photos/26275740@N00/2074092115/"><img alt="CIMG7763" src="http://static.flickr.com/2253/2074092115_954e3fb01e_m.jpg" border="0" /></a></p>  <p>Z is also enjoying living in a cul de sac so he can ride his tricycle.</p>  <p><a title="CIMG7849" href="http://www.flickr.com/photos/26275740@N00/2095087456/"><img alt="CIMG7849" src="http://static.flickr.com/2167/2095087456_4419f37445.jpg" border="0" /></a></p>  <p>You know you''re a huge nerd when you look around your garage for an half-hour for some rope to pull your son around on his bike and eventually give up and just use a Cat5 patch cable. Got plenty of those. Fortunately Z doesn''t realize this is a problem yet for our father-son relationship, but he will, somewhere around the time when he learns what "throwing like a girl" means.</p>', '2007-06-14')

INSERT INTO blogposttags (tagid, blogpostid) VALUES (9, 2);
INSERT INTO blogposttags (tagid, blogpostid) VALUES (10, 2);
INSERT INTO blogposttags (tagid, blogpostid) VALUES (11, 2);

INSERT INTO comments (blogpostid, author, comment, created) VALUES (2, 'john miller', 'You should check out rokenbok, it''s like trains + Lego + PlayStation. It''s great for a budding engineer. Also super cool for the parents and friends.', '2007-06-14 12:01:36');
INSERT INTO comments (blogpostid, author, comment, created) VALUES (2, 'Horace West', 'That is not a real Thomas set, it is a generic one, so hopefully you are safe.', '2007-06-14 12:09:36');

-- Blog Post 3
INSERT INTO blogpost (title, content, created) VALUES ('Hanselminutes Podcast 225 - Learning about NHibernate 3 with Jason Dentler', '<p><a href="http://nhforge.org/"><img style="border-right-width: 0px; margin: 0px 0px 5px 5px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="NHLogoSmall" border="0" alt="NHLogoSmall" align="right" src="http://www.hanselman.com/blog/content/binary/WindowsLiveWriter/HanselminutesPodcast225LearningaboutNHib_F594/NHLogoSmall_3.gif" width="480" height="108" /></a> My <a href="http://www.hanselminutes.com/default.aspx?showID=243">two-hundred-and-twenty-fifth podcast is up</a>. Scott chats with Jason Dentler about NHibernate and their new 3.0 release. Jason is the author of the upcoming &quot;NHibernate 3 Cookbook&quot; from Packt Publishing. Is NHibernate hard and scary? Jason gets Scott up to speed and talks open source community.</p>', '2010-08-12')

INSERT INTO blogposttags (tagid, blogpostid) VALUES (12, 3);
INSERT INTO blogposttags (tagid, blogpostid) VALUES (13, 3);
INSERT INTO blogposttags (tagid, blogpostid) VALUES (14, 3);

INSERT INTO comments (blogpostid, author, comment, created) VALUES (3, 'Paul', 'For a good introduction to NHibernate, take a look at http://www.summerofnhibernate.com/ While possible a bit dated with the release of Version 3.0. This gives the nicely paced video seried on developing with the product.', '2007-08-13 01:30:19');
INSERT INTO comments (blogpostid, author, comment, created) VALUES (3, 'http://claimid.com/luberg', 'Scott, I thought this was going to be about NHibernate 3. The whole time you guys talked about NHibernate 2 and previous, there was almost nothing about what is coming out in 3. What''s up with that?', '2007-08-13 15:34:29');


-- 5. Query the data
-- 
-- 5.1 SQL query that returns all of the blog posts, with assocaited commetns and tags
SELECT title, content, b.created, array_to_string(array_agg(t.tagname), ', '), c.author, c.comment, c.created
	FROM blogpost b
	LEFT JOIN blogposttags bt ON bt.blogpostid = b.id
	LEFT JOIN tags t ON t.id = bt.tagid
	LEFT JOIN comments c ON c.blogpostid = b.id
	GROUP BY title, content, b.created, c.author, c.comment, c.created;

SELECT title, content, b.created FROM blogpost b
	INNER JOIN blogposttags bt ON bt.blogpostid = b.id
	INNER JOIN tags t ON t.id = bt.tagid
	WHERE t.tagname = 'Z';

/* 
** Helper Queries	
SELECT * FROM tags;
SELECT * FROM blogpost;
SELECT * FROM blogposttags;
SELECT * FROM comments;
--DELETE FROM blogposttags WHERE blogpostid = 1
*/