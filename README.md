Pasteboard
====

A simple code pasteboard for sharing

JSP course assignment

DEMO: [http://pasteboard.pupa.moe](http://pasteboard.pupa.moe)

## Usage

* install `jdk8`, `maven`, `bower`, `redis` and `tomcat8`

* run `redis-server` in background

* run `bower install` in `src/main/webapp` folder

* `mvn package`

* `cp target/pasteboard.war path/to/your/tomcat/webapps`

* `cp database.sample.properties database.properties` and edit it in `src/main/resources` folder

* `catalina start`

* visit [http://localhost:8080/pasteboard](http://localhost:8080/pasteboard)

## Todo

> notification

> version control(longest common subsequence)

> full text search
