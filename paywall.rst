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
                '.tribdss.com/meter/ctcweb.js',
            dataType: 'script',
            cache: true,
            success: function() {
                trb.meteringService.modalCloseUrl = 'http://PATH_TO_MODAL_CLOSE_DIRECTORY/modal-close.html?';
            }
        });
    </script>
    <!-- Meter End -->

Finally, add a file named ``modal-close.html``, reachable at the URL you used in the above section
(``trb.meteringService.modalCloseUrl``), with the following contents:

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
http://www.latimes.com/hive/stylesheets/ssor.css.

Staging vs. production
----------------------

Chicago has had difficulty getting the staging paywall to work properly. Make sure you're using an
account that exists in the SSOR staging environment, which is one of the most common hurdles we've
encountered.
