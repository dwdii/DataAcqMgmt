# Data Acquisition & Management

This repository contains code I developed as part of my work in the 
[CUNY Master of Science, Data Analytics](http://sps.cuny.edu/programs/ms_dataanalytics) 
program's Data Acquisition and Management course (IS607) under Professor Michael Schulte.

## Highlights

### Data Analysis with R

During [week 4](https://github.com/dwdii/DataAcqMgmt/tree/master/Week4), I analyzed [IMDB](http://imdb.com) 
movie data transformed and shared by [Hadley Wickham](http://had.co.nz/). 
Some of the charts resulting from my analysis follow.

![Movies Per Decade](https://raw.githubusercontent.com/dwdii/DataAcqMgmt/master/Week4/MoviesPerDecade.png)

![Average Movie Rating By Genre per Decade](https://raw.githubusercontent.com/dwdii/DataAcqMgmt/master/Week4/AvgMovieRatingByGenreDecade.png)

![User Votes by Movie Rating](https://raw.githubusercontent.com/dwdii/DataAcqMgmt/master/Week4/UserVotesByMovieRating.png)

### Data Persistence with PostgreSQL

During [week 7](https://github.com/dwdii/DataAcqMgmt/tree/master/Week7), I imported a limited set of 
[Wikipedia WikiStats](https://aws.amazon.com/datasets/4182) data into PostgreSQL and analyzed hourly trends.
The entity-relationship diagram for the resulting database structure is shown below along with a chart showing
topic page view changes across 2 hours.

![Wikipedia data table ER diagram](https://raw.githubusercontent.com/dwdii/DataAcqMgmt/master/Week7/WikiDataDbDiagram.png)

![Top 5 Pages with increasing page views](https://raw.githubusercontent.com/dwdii/DataAcqMgmt/master/Week7/Top5ChangeWiki.png)

### Data Relationships with Graph Databases

[Weeks 11 and 12](https://github.com/dwdii/DataAcqMgmt/tree/master/Neo4j) centered around graph databases. We used [Neo4j](http://www.neo4j.com/) to get a hands on understanding of how to model data and use graph query languages like Cypher to extract information from the graph structures.

The following illustration shows hypothetical in-flight entertainment &amp; connectivity data modeled, loaded and  queried in Neo4j.

![In-flight Entertainment &amp; Connectivity](https://raw.githubusercontent.com/dwdii/DataAcqMgmt/master/Neo4j/DataModel/InFlightEntertainmentGraphIllustration.png)

### Data Performance
As part of an analysis of performance in various data technologies, I studied how R's `sum` function performed under different data scenarios. The [resulting article](https://rpubs.com/dwdii/R-SumInParallel) is available though [my RPubs.com profile](https://rpubs.com/dwdii).
