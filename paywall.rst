Paywall
=======

How to enable the paywall
-------------------------

Include the following CSS files in the ``<head>`` section of any page you'd like to show the paywall
on:

.. code-block:: html

    <!-- SSOR Start CSS -->
    <link href="http://www.chicagotribune.com/hive/stylesheets/ssor.css" media="all" rel="stylesheet" type="text/css" />
    <link href="http://www.chicagotribune.com/hive/stylesheets/registration_signin/registration.css?v=15" media="all" rel="stylesheet" type="text/css" />
    <!-- SSOR End CSS -->

Include the following Javascript in any page you'd like to show the paywall on:

.. code-block:: html

    <!-- SSOR Start -->
    <script src="http://www.chicagotribune.com/hive/javascripts/registration_signin/registration-global.js?v=15"></script>
    <script>
        registration.manager.config.initialize({
            productCode: "chinews",
            brandingSiteName: "chicagotribune.com",
            registrationHostname: "https://chinews.signon.trb.com",
            metricsCookieName: "metrics_id"
        });
    </script>
    <!-- SSOR End -->
    <!-- Meter Start -->
    <script>
        jQuery.ajax({
            url: '//' +
                (location.protocol=='https:' ? 's' : 'www') +
                '.tribdss.com/meter/PRODUCT_CODE.js',
            dataType: 'script',
            cache: true,
            success: function() {
                trb.meteringService.modalCloseUrl = 'http://PATH_TO_MODAL_CLOSE_DIRECTORY/modal-close.html?';
            }
        });
    </script>
    <!-- Meter End -->

You will need to replace ``PRODUCT_CODE`` above with the appropriate code for your property's
paywall. For most Chicago Tribune projects, the product code is "ctcweb" and for most Los Angeles
Times projects, the product code is "latweb". If you don't know the right code, or you're not sure
how to find it, head down to the `Setting Up Paywall Rules in DSS section
<#setting-up-paywall-rules-in-dss>`_ below.

You will also need to add your project in place of ``PATH_TO_MODAL_CLOSE`` as the reachable URL in
the above section (``trb.meteringService.modalCloseUrl``). For example,
graphics.chicagotribune.com/yourproject.

Finally, add a file named ``modal-close.html`` to your project directory, with the following contents:

.. code-block:: html

    <script src="http://www.chicagotribune.com/hive/javascripts/registration_signin/helper/modal-close.js"></script>
    <!-- <script src="http://www.chicagotribune.stage.tribdev.com/hive/javascripts/registration_signin/helper/modal-close.js"></script -->

You may have noticed that one of the above lines is commented out; this is because the path to the 
``modal-close.js`` file is different depending on whether you're deploying this code to a staging 
environment or production. Make sure that the correct line is uncommented, depending on which 
environment you're working in.

Example using Tarbell
---------------------

If you're using Tarbell, much of the above work has already been done for you. All you need to do is
include the appropriate paywall template partial (for either staging or production) inside the
``paywall`` block, as follows:

.. code-block:: django

    {% block paywall %}
        {% include "_paywall_prod.html" %}
    {% endblock paywall %}

If you'd like to use the staging environment locally but the production environment when deployed, add
a little logic:

.. code-block:: django

    {% block paywall %}
        {% if PREVIEW_SERVER %}
            {% include "_paywall_stage.html" %}
        {% else %}
            {% include "_paywall_prod.html" %}
        {% endif %}
    {% endblock paywall %}

Setting up paywall rules in DSS
-------------------------------

In order to set up a paywall for a project, you need to determine the appropriate code for the
product it belongs to (for example, "ctcweb" for most Chicago Tribune projects). To do this, visit
the `DSS site in P2P <http://dss.p2p.tribuneinteractive.com/>`_, hover over the market you're
interested in and click Products, and then click the product that seems to most closely match the
site you're building. The code will be the first thing listed.

You'll also need to ensure that the URL(s) of the pages you'd like to be behind the paywall are
already covered by the relevant rule. To determine whether this is the case, click on the Rules tab
of the product page (the one in the previous paragraph, in which you found the product code) and
look for the "premium" module. The "free" module governs sections of the product that won't present
a paywall modal, and the "register" module governs those sections for which users must register but
not pay. Since you're setting up the paywall, you need the "premium" module, but the following
concepts should apply equally to all three types.

The Chicago Tribune Producer's Guide contains `a walkthrough that covers how to add and update URL
patterns <http://chicagotribuneguide.wordpress.com/2012/02/24/paywall-setup/>`_. Each pattern
consists of three sections, the first two of which use `regular expressions
<http://www.regular-expressions.info/quickstart.html>`_, or small bits of text that match other bits
of text. The main thing you should know is, in regular expressions, ``*`` is a wildcard: it matches
everything. So the pattern ``*/news-*.html`` would match both "chicagotribune.com/news-story.html"
and "latimes.com/news-update.html".

If you're adding or updating a rule for your site or page, you just need to make sure that there's
a pattern in the appropriate rule that matches your page's URL(s). Keep in mind all the different
possible variations of those URLs, chiefly that if your URLs normally start with a "www" it may
still be possible to access those pages without the "www".

Host pattern
    Think of the host as "everything in a URL between the ``http://`` and the first /. So for the
    URL "chicagotribune.com/news" then "chicagotribune.com" is the host; for "www.sun-sentinel.com"
    the host is "www.sun-sentinel.com" even though there's no trailing slash.
    
    If users can access your content with or without the "www." at the beginning, you probably need
    two rules: one where the host pattern is "exampledomain.com" and one where the host pattern is
    either "www.exampledomain.com" (if you know that other subdomains aren't an option) or the more
    general "*.exampledomain.com" (if "sports.exampledomain.com" and "www.exampledomain.com" both
    lead to your content).

Path pattern
    For this purpose, the path is everything from the first / to the end of the URL. The path must
    start with a "/". For the URL "baltimoresun.com/news/local/story.html" the path is
    "/news/local/story.html".
    
    The trick here is to be as specific as possible, but never overly specific - you want to make
    sure all of your possible URLs match the rule, but you don't want your rule to match other
    projects' URLs. If all of your URLs will be in the "/news/local" section, therefore, you should
    start your path pattern with "/news/local" - that way, you're being specific. If most of them
    will end in ".html" but even one will end in ".story", then you should end your pattern with
    ".*".

Content URL or referrer dropdown
    The distinction here is simply whether you want the rule to the URL of your content, or to the
    URL of the page that referred your users to your content. Most of the time, you want "Content
    URL" - the other option, "Referrer" is mainly for use in applying different paywall rules to
    visitors coming in from social media.

Once you've created or updated the rule, you can test your URLs out to make sure they match - click
on the Test URL box near the top of the main rules list, enter in as many different variations of
your URLs as you think users are capable of using, and make sure that your rule matches all of them.


Changing paywall appearance or behavior
---------------------------------------

You may be tempted to customize the look and feel of the paywall modal, or only trigger it in 
certain conditions. In general, the experience of the Chicago News Apps team has been that this may 
not be a good idea. Since the code isn't under your control, it can be difficult to implement and 
test any changes you want to make. Further, the underlying paywall implementation can change 
underneath your feet, breaking your page, without you getting advance notice.

Use by different markets
------------------------

The above code samples all assume you're using Chicago's paywall. If that's not the case, 
everything should still work as described, but you'll have to swap out the Hive URLs from 
chicagotribune.com for your own. For instance, the main Chicago SSOR CSS file lives at
http://www.chicagotribune.com/hive/stylesheets/ssor.css, while the equivalent LA file lives at 
http://www.latimes.com/hive/stylesheets/ssor.css. As described in the `Setting Up Paywall Rules in
DSS section <#setting-up-paywall-rules-in-dss>`_, you'll also need to determine the appropriate
product code and ensure that the relevant rules are in place.

Staging vs. production
----------------------

Chicago has had difficulty getting the staging paywall to work properly. Make sure you're using an
account that exists in the SSOR staging environment, which is one of the most common hurdles we've
encountered.
