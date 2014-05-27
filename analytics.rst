Analytics
=========

Omniture
--------
.. NOTE: Due to refactoring that needs to happen with our omniture library, it is not currently documented.
  See this ticket for information on using omniture.js: https://tribune.unfuddle.com/a#/projects/6/tickets/by_number/566

The Tribune uses Omniture to track pageviews on its main sites. Here's how to use it on non-P2P projects.

Omniture variables
^^^^^^^^^^^^^^^^^^

.. note::
  A "path" in Omniture is equivalent (usually) to the subsection a project is associated with. For instance,
  ``http://www.chicagotribune.com/news/local/breaking/`` has an Omniture path of
  ``Chicago Tribune / news / local / breaking``. Those projects with a URL like ``community.chicagotribune.com``
  have paths corresponding to the first part of their URL, e.g., ``Chicago Tribune / community``.

There are a number of unintuitvely named variables that Omniture tracks. These are the ones we care about:

**s_account**

The account that pageviews roll up to in reports. For staging sites, this is "tribglobaldev" and for production,
it is "tribglobal." Example::

  var s_account = "{% if PREVIEW_SERVER %}tribglobaldev{% else %}tribglobal{% endif %}";

**pageName**

The page's title, plus some information about the project's path. This includes the name of the organization, the
section which contains the project, and the project's hierarchy in the site. Example::
  Chicago architecture firms are redesigning China - Chicago Tribune - Chicago Tribune / news -- News application, 3rd Party.

  Project name - Organization name - Path -- hierarchy.

**server**

Always ``www.chicagotribune.com``.

**channel**

This equates to the path of the section the project rolls up to. If you have a project that belongs under
"news/local/breaking" the channel would be ``Chicago Tribune:news:local:breaking``, with colons replacing the slashes.

**prop38**

Refers to the content type of the page. Most things living outside P2P should be classified "3rd Party".

**eVar21**

The same as prop38.

**hier1**

The path with the prefix of the news organization the page belongs to. "Chicago Tribune" for Chicago, but not all
are exactly the name of the org::

  Chicago Tribune:news:local:breaking

**hier2**

The path without the organizational name prefixing it::

  news:local:breaking

**hier4**

The same as hier2.


Omniture in Tarbell
^^^^^^^^^^^^^^^^^^^
Tarbell's base blueprint provides an Omniture block that can pull variables from your Google spreadsheet. Specifically,
the path can be set by giving ``analytics_path`` a value.

Tarbell's Omniture block is reproduced here in its entirety::

  {% block omniture %}
  <script type="text/javascript">
      var s_account = "{% if PREVIEW_SERVER %}tribglobaldev{% else %}tribglobal{% endif %}";
  </script>
  <!-- START OMNITURE // hive:metrics-tribune -->

  <!-- SiteCatalyst code version: H.1.
  Copyright 1997-2005 Omniture, Inc. More info available at
  http://www.omniture.com -->
  <script type="text/javascript" src="http://www.chicagotribune.com/hive/javascripts/metrics/s_code_trb.js">
  </script>
  <script type="text/javascript">
  var title = (document.title && document.title.length > 0) ? document.title + ' - ' : '';
  s.pageName= title + "Chicago Tribune / {{ analytics_path|strip_slashes|replace('/', ' / ') }} -- News application, 3rd Party"; 
  s.server="www.chicagotribune.com"
  s.channel="Chicago Tribune:{{ analytics_path|strip_slashes|replace('/', ':') }}";
  s.prop38="3rd Party";
  s.eVar21="3rd Party";
  s.hier1="Chicago Tribune:{{ analytics_path|strip_slashes|replace('/', ':') }}";
  s.hier2="{{ analytics_path|strip_slashes|replace('/', ':') }}";
  s.hier4="{{ analytics_path|strip_slashes|replace('/', ':') }}";

  /************* DO NOT ALTER ANYTHING BELOW THIS LINE ! **************/
  var s_code=s.t();if(s_code)document.write(s_code)
  -->
  </script><script type="text/javascript">
  <!--
  if(navigator.appVersion.indexOf('MSIE')>=0) document.write(unescape('%3C')+'\!-'+'-')
  //-->
  </script><!--/DO NOT REMOVE/-->
  <!-- End SiteCatalyst code version: H.1. -->
  <!-- START REVENUE SCIENCE PIXELLING CODE -->
  <script src="http://js.revsci.net/gateway/gw.js?csid=B08725" type="text/javascript"></script>
  <script type="text/javascript">
    DM_addEncToLoc("Site", (s.server));
    DM_addEncToLoc("channel", (s.channel));
    DM_addEncToLoc("keyword", (s.prop3));
    DM_cat(s.hier1);
    DM_tag();
  </script><!-- END REVENUE SCIENCE PIXELLING CODE -->
  <!-- Time: Tue May 11 15:01:30 PDT 2010-->
  <!--x-Instance-Name: i9s27n1-->
  {% endblock omniture %}

Debugging
^^^^^^^^^

There is a `debugging bookmarklet available from Adobe <http://blogs.adobe.com/digitalmarketing/analytics/meet-the-new-digitalpulse-debugger/>`_.
Install, then load your page and click the DigitalPulse bookmark. You should see Omniture values populate the fields in the
pop-up window that opens.

Google analytics
----------------

Use this script to add Google analytics to your project, making sure the ``UA-`` identifier is correct for your market.
This is what it would look like for Chicago::

  <script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-9792248-25']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
  </script>

Tarbell projects include this code in the _base.html file within ``{% block google_analytics %}``.


Chartbeat
---------

To configure Chartbeat, all you need to know is the UID of the desired property and the domain you wish to funnel
traffic from::

  <script type='text/javascript'>
    var _sf_async_config={};
    /** CONFIGURATION START **/
    _sf_async_config.uid = 3096;
    _sf_async_config.domain = 'apps.chicagotribune.com';
    _sf_async_config.useCanonical = true;
    _sf_async_config.sections = '{{ title }}';
    /** CONFIGURATION END **/
    (function(){
      function loadChartbeat() {
        window._sf_endpt=(new Date()).getTime();
        var e = document.createElement('script');
        e.setAttribute('language', 'javascript');
        e.setAttribute('type', 'text/javascript');
        e.setAttribute('src', '//static.chartbeat.com/js/chartbeat.js');
        document.body.appendChild(e);
      }
      var oldonload = window.onload;
      window.onload = (typeof window.onload != 'function') ?
         loadChartbeat : function() { oldonload(); loadChartbeat(); };
    })();
  </script>


Tarbell projects include this code in the _base.html file within ``{% block charbeat %}``.
