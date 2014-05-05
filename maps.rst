Maps
====

When to make a map, and when not to
-----------------------------------

The most important question to ask when you're about to build an interactive map is, Why? Not all
data that can be mapped is best served as one. For more perspective on when to use a map, we
recommend `this thoughtful blog post
<http://www.ericson.net/content/2011/10/when-maps-shouldnt-be-maps/>`_.

Before you decide to build a map, think carefully about what you want readers to understand
about the data you're presenting and whether a map is the clearest expression of that intention.

How to use Leaflet.js
---------------------

Now that you've carefully pondered your options and concluded that a map is the best choice to
visualize your data, it's time to start building it. There are an incredible number of choices here,
but we're going to walk you through building a map using `Leaflet.js <http://leafletjs.com/>`_.
We prefer to use Leaflet whenever possible because it's responsive by default, allows for the use
of arbitrary tilesets and data providers, has `good documentation online
<http://leafletjs.com/reference.html>`_, is generally very flexible and powerful and works across
a wide array of browsers and platforms.

Before going any further, again: the `Leaflet documentation <http://leafletjs.com/reference.html>`_
is really, really good, so you might want to open that up in a new tab and/or bookmark it. It's way
more comprehensive than this documentation will ever be.

To get started, first include the Leaflet CSS and JS files:

.. code-block:: html

    <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.1/leaflet.css" />
    <!--[if lte IE 8]>
        <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.1/leaflet.ie.css" />
    <![endif]-->
    <script type="text/javascript" src="//cdn.leafletjs.com/leaflet-0.7.1/leaflet.js"></script>

You'll also need a ``<div>`` element on the page with an id (it can be anything; we'll use "map" for
this example) and a defined height:

.. code-block:: html

    <style type="text/css">
        #map { height: 300px; }
    </style>
    <div id="map"></div>

We're also going to assume you're using `jQuery <http://jquery.com/>`_, a very powerful and flexible
library; we'll mainly use it here to wait for the page to finish loading before we build our map.

.. code-block:: javascript

    $(document).ready(function() {
        // Code you put here won't run until the page is finished loading
        // So for now, put all your mapping code here - though you'll eventually want to decompose
        // it into separate functions before it becomes unmanageably large.
    });

When we include leaflet.js on the page, it will create a JavaScript object named ``L`` that
allows us to access all the leaflet functionality we need. We begin by creating a map object and
tying it to the "map" ``<div>`` we created above.

.. code-block:: javascript

    var map = L.map('map');

Leaflet needs to know where to center the map, and what zoom level to start out at. Let's give it
the latitude and longitude coordinates for Chicago, and zoom it to a level that lets us see some
detail about the city; higher numbers indicate a closer zoom, showing more detail.
We typically don't allow zooming in beyond level 16, or zooming out beyond level 9, but that varies
depending on the size of your map and the geographic area you're covering.

.. code-block:: javascript

    map.setView([41.838299, -87.706953], 11);

Now we need to add a tileset to the map. Tilesets are basically collections of small square
images that contain sections of a map; when you drag the map, Leaflet (or Google Maps, or any other
web mapping system) loads new tiles that cover the region being dragged into view. When you think of
a draggable map you've seen online, almost everything on that map came from a tile. Here's what one
looks like:

.. image:: http://maps4.tribapps.com/chicago-print/11/524/761.png

In this example, we'll use a generic tileset from `OpenStreetMap <http://www.openstreetmap.org/>`_;
the NewsApps team has a custom tileset for Chicago, about which you can learn more in the next
section, `Using Chicago's tileset <#using-the-chicago-tileset>`_. The principles of adding tilesets
to Leaflet are the same, no matter what tileset you're using; the only thing that really changes is
the URL you pass Leaflet.

.. code-block:: javascript

    L.tileLayer(
      'http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: 'Map data &copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
        maxZoom: 16,
        minZoom: 9
    }).addTo(map);

Obviously, there's a lot going on here, so let's unpack it line by line. ``L.tileLayer()`` takes a
URL template (more on that in a second) that tells Leaflet where to find the tileset, as well as
some options, and returns a tile layer object. Chaining ``.addTo(map)`` tells Leaflet to add the
tile layer we just created to the ``map`` object.

The URL template (``'http://{s}.tile.osm.org/{z}/{x}/{y}.png'``) should point to a
specially-constructed directory containing the tileset. The details of creating that directory are
outside the scope of this document, but the characters in brackets in the template string are filled
in by Leaflet. They refer to the subdomain to use ({s}, allowing Leaflet to spread
requests across multiple servers to reduce load and improve speed), the zoom level ({z}) and the
geographic area to cover ({x} and {y} coordinates).

The attribution string contains the text that will be placed in the bottom-right corner of the map,
and should mainly refer to the data source(s) you're using for the map data.

``maxZoom`` and ``minZoom`` refer to the maximum and minimum zoom levels allowed for this tileset.

At this point, we have a basic, functional map, so now we can start doing some interesting things.

Adding a marker
---------------

The `Leaflet documentation on markers <http://leafletjs.com/reference.html#marker>`_ is pretty
great, so be sure to check it out. But here's a simple example.

The only thing you really need to add a marker to a Leaflet map is the latitude and longitude where you'd
like the marker to appear. Our map is centered on Chicago in our previous example, so let's put a
marker at the center of Chicago:

.. code-block:: javascript

    L.marker([41.838299, -87.706953]).addTo(map);

Wait, that's it? Yeah, pretty much. This will place a nice little blue marker at the center of the
city of Chicago, but it won't do anything else. You might want to add a little popup whenever the
user clicks the marker, so let's get a bit fancier:

.. code-block:: javascript

    var marker = L.marker([41.838299, -87.706953]);
    marker.bindPopup('<h1>This is a marker</h1>');
    marker.addTo(map);

Since ``L.marker()`` returns a marker object, we can store it in a variable (named "marker",
conveniently enough) and get access to a variety of interaction options before adding it to the map.
The string you pass to ``bindPopup()`` contains the contents of the popup that will appear above
the marker, and supports HTML.

Adding a custom marker icon
---------------------------

The default marker is a bit boring, however, and certainly can make a map confusing if many markers
that all look identical are added. Fortunately, Leaflet makes it easy to add a custom marker icon:

.. code-block:: javascript

    var new_icon = L.icon({
        iconUrl: 'new_icon.png',
        iconSize: [70, 70],
    });
    L.marker([41.838299, -87.706953], {icon: new_icon}).addTo(map);

The URL in ``iconUrl`` should be either absolute (i.e., http://www.domain.com/image.png) or relative
to the location of your Javascript (so if the Javascript file is at
http://www.chicagotribune.com/leaflet/map.js, and you have an icon image at
http://www.chicagotribune.com/leaflet/icon.png, then a valid ``iconUrl`` would be 'icon.png').

``iconSize`` refers to the size of the icon displayed onscreen (rather than the actual size of the
image file); the first value is the width, and the second value is the height; both are in pixels.

By default, as demonstrated in the example above, giving Leaflet just an ``iconSize`` will mean that 
the icon image is centered directly on top of the lat/lng coordinate pair you give the marker. Most
of the time, that's probably what you want; it's certainly the simplest option. However, for some
types of marker icons (like arrows) the part of the icon that rests atop the lat/lng coordinates
isn't in the direct center of the icon image. In those cases, Leaflet offers an ``iconAnchor``
property that lets you customize where the icon appears relative to the lat/lng coordinates you give
the marker, but this can be somewhat confusing and is therefore outside the scope of this document.

Using the Chicago tileset
-------------------------

The News Apps team has created a custom tileset for use in the city of Chicago and the surrounding
suburbs. We recommend using it for all maps that cover this geography, as the muted color scheme and
hand-selected geographic features are a better fit for news applications than the standard
OpenStreetMap tiles.

The following is an example of how to use this tileset, which has much in common with the example
given in the walkthrough above:

.. code-block:: javascript

    L.tileLayer(
      'http://{s}.tribapps.com/chicago-print/{z}/{x}/{y}.png', {
        subdomains: ['maps1', 'maps2', 'maps3', 'maps4'],
        attribution: 'Map data &copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
        maxZoom: 16,
        minZoom: 9
    }).addTo(map);

Besides the different URL template, the only real difference is that we're using 4 subdomains
instead of the default 1. The key is that all 4 of the subdomains contain the exact same data, so
Leaflet is free to spread requests among all 4 of them without it mattering which subdomain serves
which tile.

Basic interactive map example
-----------------------------

The following is a complete, soup-to-nuts example of creating an interactive, responsive map based
on all the code discussed in this documentation.

.. code-block:: html

    <html>
      <head>
        <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.1/leaflet.css" />
        <!--[if lte IE 8]>
          <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.1/leaflet.ie.css" />
        <![endif]-->
        <script type="text/javascript" src="//cdn.leafletjs.com/leaflet-0.7.1/leaflet.js"></script>
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>

        <style type="text/css">
          #map { height: 300px; }
        </style>
      </head>
      <body>
        <div id="map"></div>

        <script type="text/javascript">
          $(document).ready(function() {
            // Initialize the map, point it at the #map element and center it on Chicago
            var map = L.map('map').setView([41.838299, -87.706953], 11);
            
            // Add the OpenStreetMap tile layer
            L.tileLayer(
              'http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
              attribution: 'Map data &copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
              maxZoom: 16,
              minZoom: 9
            }).addTo(map);

            // Add a marker
            var marker = L.marker([41.838299, -87.706953]);
            marker.bindPopup('<h1>This is a marker</h1>');
            marker.addTo(map);
          });
        </script>
      </body>
    </html>
