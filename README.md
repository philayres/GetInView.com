GetInView - Public Website
====

The GetInView website is the front end to a the GetInView accommodation listings
and bookings service. GetInView is an experiment to see if hotel listings 
services can be easily provided to both guests and property owners / managers,
all without charging listing fees or booking commissions.

A description of the service is available at:
https://www.getinview.com/free_online_listing

GetInView is supported by a backend administration console that allows admins
to enter and maintain property information.

Installation
---

Clone the repository.

Then setup with:

    rails db:setup

This should create the development user and database schema directly from the
supplied schema. Migrations are not provided, since the database is managed by
the GetInView console.

A limited set of rspec tests are provided to ensure baseline functionality of 
the website. Just run rspec to ensure setup is correct and the application is
operational.

Security
---

The population of data relies on the GetInView admin console. This also owns the
schema and associated migrations. In a production environment, the DB user for 
the public website is granted only read access to the tables, to provide 
additional security. A typical architecture might also consider just a one-way
replication of the appropriate data from the central admin database to the 
DB behind the public facing website.

In the future, certain public user authenticated functions will likely require 
DB writes. These will be opened up on a table per table basis. 

Prerequisites
---

**Memcache** - provides user session caching and API call result caching
**MySql** was the selected database, avoiding the Postgres case-sensitivity
**Google Static Maps** provides maps, and an API key is required

Licence
---

Copyright 2017 Consected

Currently a licence has not been selected. We are working on selecting the most
appropriate licence for all portions of the GetInView service. For licencing 
questions, please contact info@consected.com
