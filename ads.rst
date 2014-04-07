Ads
========

How Tribune ads work
--------------------

We serve ads by inserting ``<iframe>`` s into a page that contain all the code needed to display an
ad. The adops team maintains a system that determines which ads to place on which pages, based on
the page's section path, and they also serve the ad content itself, by way of `Google AdSense
<http://www.google.com/adsense>`_.

Therefore, in order to incorporate ads on a page, all you need to do is set up a page element that
will contain an ad. Then set the contents of that element to contain the contents of the adops page,
passing some data to adops in the process that tells it what section to use and what size you want,
and you're done.

Although it's certainly possible to do all this yourself, the Trib Apps team has a Javascript
library that takes care of most of the messy work for you, so this documentation will primarily
focus on how to use that library.

Using the ads library
---------------------

At the time of writing, the most current version of the ads library is located at
`http://s3.amazonaws.com/media.apps.chicagotribune.com/ads/v2.1.2/ads.js
<http://s3.amazonaws.com/media.apps.chicagotribune.com/ads/v2.1.2/ads.js>`_ (but you should
probably only use `the minified version
<http://s3.amazonaws.com/media.apps.chicagotribune.com/ads/v2.1.2/ads.js>`_ in your projects, since
it's smaller and loads faster).

This library relies on the presence of a file available at the same domain as your page, typically
called ``ad-iframe.html``. The name doesn't matter much, but it's very important the file be at the
same domain. For instance, if your page is at apps.chicagotribune.com/news/article, then the file
needs to be at apps.chicagotribune.com/ad-iframe.html (or even
apps.chicagotribune.com/news/adstuff.html; as long as it starts with apps.chicagotribune.com, you're
fine).

To get started, first import the library: ::

    <script src="//s3.amazonaws.com/media.apps.chicagotribune.com/ads/v2.1.2/ads.min.js"></script>

And set up the body of the page to pass the correct parameters to adops: ::

    <body
        data-ad-path="/4011/trb.chicagotribune/news"
        data-ad-ptype="s"
        data-ad-iframe-url="/ad-iframe.html"
    >

A few things just happened here. We told adops what ID to associate with our request, what property
we're from, and what section path to use ("4011", "trb.chicagotribune" and "news", respectively).
The first two should be the same across all Chicago Tribune projects, but will obviously be
different for different properties. The latter should be determined in consultation with adops,
since it needs to match what they have in their system.

``data-ad-ptype="s"`` told our ad code that this page is a story ("s"), rather than a section front
("sf") or a photo gallery ("pg"). The last line of that block told our ad code where to find the
ad-iframe.html file.

Now you just have to create at least one element to receive the ad itself, typically a ``<div>``.
The element(s) must have the class ``advert`` and should tell the library what type of ad to place
in that position; if none is specified, the library will insert a leaderboard: ::

    <div class="advert" data-type-type="cube"></div>

At this point, when you load the page, a cube ad should appear in that ``<div>``.

Types of ads we support
-----------------------

All of the ads.

Out-of-page (OOP) ads
---------------------

Typical ad maps
---------------

This is kind of redundant.

Example using Tarbell
---------------------

See also the Tarbell doc.

Full example for non-Tarbell sites
----------------------------------

Here ya go.
