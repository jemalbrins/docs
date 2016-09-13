Web Applications
================

This is a place to document "web applications."  I'm not sure of a great definition for these, but I'll define them as "things we've built that run on a server and return different information based on different user requests."  This is different than many of the static sites that we build where users either see the same HTML, or where dynamic interactions happen on the client side with `JavaScript`.

The goal of this documentation is to give some background if you encounter a dependency on one of these applications in the code of another project.  It's also a good way to keep track of our potential technical debt. These applications tend to be somewhat complicated and need to run on servers which cost money and need periodic maintenance. 

Sites
-----

### Election Center

URL: [http://elections.chicagotribune.com/](http://elections.chicagotribune.com/)

TODO: Describe this

### Crime in Chicagoland

URL: [http://crime.chicagotribune.com/](http://crime.chicagotribune.com/)

TODO: Describe this

Services
--------

A service is different than a site because it provides functionality that other apps can use.  In software engineering jargon, this is often called an application program interface (API).  In many cases, their may be interfaces where a human can interact with the service as well, either to add new information or do one-off lookups of information. 

### Listbuilder

URL: [https://listbuilder.tribapps.com/](https://listbuilder.tribapps.com/)

#### What does it do?

Listbuilder is a [microservice](http://martinfowler.com/articles/microservices.html) that provides a REST API that other applications can use to create and retrieve lists of arbitrary things. 

#### How do I use it?

You need to login to the Django admin for this app and create a new list.  Then add the JavaScript library to your project.  Finally, interact with Listbuilder's REST API using the JavaScript library.

More information about this service can be found in the [project README](https://tribune.unfuddle.com/a#/projects/6/repositories/338/file?path=%2FREADME.md)

#### When should I use it?

* You have a static site but you want to add some user interactivity by allowing them to select items.  We originally built the service for the [Eat This, Drink This](http://apps.chicagotribune.com/entertainment/dining/eatthis/) dining guide and also used it for [Bears Predictions](http://graphics.chicagotribune.com/sports/football/bears/bears-breakdown/2015/predictions/) to handle the user picks.
* Your content is already structured around a list of things

#### When shouldn't I use it?

* When you don't have a unique way to identify users
* When you're collecting sensitive or private information from users
* If you've never worked with a REST API and don't have time to learn about them generally
* If you haven't used a library in your JavaScript code

### Boundary Service

URL: http://boundaries.tribapps.com/

TODO: Write this.

### Bing Bulk Geocoder

URL: http://geo.tribapps.com/

#### What does it do

Geocodes a spreadsheet's worth of addresses.

#### How do I use it?

Go to the URL and follow the instructions.  It all happens in your browser/email.

#### When do I use it?

When you need to geocode many records and you want to use them however you want (for data analysis, for a map). Many other geocoders restrict how you can use the geocoded data.  For example, Google has a great geocoder, but you can only use geocoded points on a map if it's a Google Map. 

#### When shouldn't I use it?

* When you just need one address geocoded.  For that, you can use the Boundary Service.
* When it breaks.  You could try the [Texas A&M Geoservices Batch Geocoder](http://geoservices.tamu.edu/Services/Geocode/BatchProcess/) or the [U.S. Census Bureau Geocoder](http://geocoding.geo.census.gov/).


### NewsroomDB 

TODO: Write this.

### PANDA

TODO: Write this.
