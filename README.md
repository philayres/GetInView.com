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
the website.

Licence
---

Copyright 2017 Consected

Currently a licence has not been selected. We are working on selecting the most
appropriate licence for all portions of the GetInView service. For licencing 
questions, please contact info@consected.com
