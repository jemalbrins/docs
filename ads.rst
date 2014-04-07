Ads
========

How Tribune ads work
--------------------

We serve ads by inserting ``<iframe>`` s into a page that contain all the code needed to display an
ad. The adops team maintains a system that determines which ads to place on which pages, based on
the page's section path, and they also serve the ad content itself, primarily by way of
`Google AdSense <http://www.google.com/adsense>`_ and
`Doubleclick <https://www.google.com/doubleclick/>`_.

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

The ad library currently (as of v2.1.2) supports three separate ad types:

leaderboard
    The default, 728 pixels wide and 90 pixels high. On mobile devices, this will be automatically
    resized to 320x50.

cube
    The other most commonly-used type, 300 pixels wide by 250 pixels high. Inventory for this slot
    can sometimes be sold to ads that are 300x600, i.e. a doubly-tall cube. Although the ad code
    handles this fine, your page layout may be affected by the presence of a 600px-high ad in a
    space normally reserved for an ad 250px tall.

shrinky-cube
    A normal cube ad (300x250) at desktop resolutions, that automatically shrinks down to become a
    320x250 leaderboard for mobile devices.


Out-of-page (OOP) ads
---------------------

Although not directly supported by our ads library, OOP ads are commonly used across Tribune
properties, and allow us to sell more interactive ads like reskins, takeovers and peelbacks. To
enable an OOP ad on a page, you have to set up a few `Google Publisher tags
<https://support.google.com/dfp_premium/answer/1650154?hl=en>`_ in the document ``<head>``: ::

    <!-- Start: GPT Async -->
    <script type='text/javascript'>
        var gptadslots=[];
        var googletag = googletag || {};
        googletag.cmd = googletag.cmd || [];

        (function(){
            var gads = document.createElement('script');
            gads.async = true;
            gads.type = 'text/javascript';
            var useSSL = 'https:' == document.location.protocol;
            gads.src = (useSSL ? 'https:' : 'http:') + '//www.googletagservices.com/tag/js/gpt.js';
            var node = document.getElementsByTagName('script')[0];
            node.parentNode.insertBefore(gads, node);
        })();
    </script>

    <script type="text/javascript>
        googletag.cmd.push(function() {
            //Adslot oop declaration
            gptadslots[0] = googletag.defineOutOfPageSlot(
                '/4011/trb.chicagotribune/news',
                'div-gpt-ad-oop').addService(googletag.pubads());
            googletag.pubads().setTargeting('ptype',['sf']);
            googletag.pubads().enableAsyncRendering();
            googletag.enableServices();
        });
    </script>
    <!-- End: GPT -->

This code does a few things worth pointing out. As in the example from `"Using the ads library"
<#using-the-ads-library>`_ above, it declares that this page should have the ID "4011", be
associated with the "trb.chicagotribune" property, and receive ads for the "news" section path.

As in the above example, this code also sets the page type we're rendering (this example is for a
section front, so we send Google "sf" instead of "s" this time).

Otherwise, you shouldn't need to customize this code in order to enable OOP ad slots on your page.
However, OOP ads can often be disruptive to the normal layout of a page, so it's always a good idea
to test them before they go live, if at all possible. One way to do so is to use a separate section
path designated for testing/staging environments, allowing OOP ads to be programmed for that section
without appearing on any live page. This should be coordinated with adops.

Ideal ad map
------------

The ad map is the list of which types of ads are designated for which positions on the page. Our ads
code mostly abstracts this away so you don't need to worry about it, but if you're interested, or
thinking about what types of ads to put on a new page, here's the standard ad map:

1) Leaderboard (728x90/320x50)
2) Cube (300x250/300x600)
3) Reskin
4) Cube (300x250/300x600)
5) OOP (1x1)
6) Sponsorship logo
7) Cube (300x250/300x600)

Note that not all of these will be present on all pages. For instance, not all pages have room for
the third cube ad, nor does the homepage always contain a leaderboard.

Example using Tarbell
---------------------

TK. It looks like the base template needs to be slightly rewritten to facilitate this.

Full example for non-Tarbell sites
----------------------------------

.. code-block:: html

    <html>
        <head>
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
            <script src="//s3.amazonaws.com/media.apps.chicagotribune.com/ads/v2.1.2/ads.min.js"></script>

            <!-- Start: GPT Async -->
            <script type='text/javascript'>
                var gptadslots=[];
                var googletag = googletag || {};
                googletag.cmd = googletag.cmd || [];

                (function(){
                    var gads = document.createElement('script');
                    gads.async = true;
                    gads.type = 'text/javascript';
                    var useSSL = 'https:' == document.location.protocol;
                    gads.src = (useSSL ? 'https:' : 'http:') +
                        '//www.googletagservices.com/tag/js/gpt.js';
                    var node = document.getElementsByTagName('script')[0];
                    node.parentNode.insertBefore(gads, node);
                })();
            </script>

            <script type="text/javascript>
                googletag.cmd.push(function() {
                    //Adslot oop declaration
                    gptadslots[0] = googletag.defineOutOfPageSlot(
                        '/4011/trb.chicagotribune/news',
                        'div-gpt-ad-oop').addService(googletag.pubads());
                    googletag.pubads().setTargeting('ptype',['s']);
                    googletag.pubads().enableAsyncRendering();
                    googletag.enableServices();
                });
            </script>
            <!-- End: GPT -->
        </head>

        <body
            data-ad-path="/4011/trb.chicagotribune/news"
            data-ad-ptype="s"
            data-ad-iframe-url="/ad-iframe.html"
        >

            <div class="advert" data-type-type="cube"></div>

        </body>
    </html>
