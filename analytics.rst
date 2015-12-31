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
  ``chicagotribune:news:local:breaking``. Those projects with a URL like ``community.chicagotribune.com``
  have paths corresponding to the first part of their URL, e.g., ``ct:community``.

  A "project type" is simply a descriptor for the kind of website you're tagging. There are seven predetermined
  project type options you can choose: articleproject, dataproject, individualarticle, individualgraphic, landingpage,
  photogalleryproject, 3rdparty.

There are a number of variables that Omniture tracks. These are the ones we care about:

**pageName**

The page's title, plus some information about the project's path. This includes the abbreviation of the organization, the domain the project lives on, the section that contains the project, the name of the individual page, and the type of project it is. Example::

  ct:graphics:news:features:Eastland-Disaster:dataproject

  Organization abbreviation : domain : path : page name : project type.

**channel**

The path the project rolls up to. If you have a project that belongs under
"news/local/breaking," then the channel would be ``news:local:breaking``.

**server**

The domain of the project. Example::

  graphics.chicagotribune.com

**hier1**

The path with the prefix of the news organization the page belongs to. "Chicago Tribune" for Chicago, but not all
are exactly the name of the org::

  chicagotribune:news:local:breaking

**hier2**

The path without the organizational name prefixing it::

  news:local:breaking

**prop1**

The same as the pageName value. So use ``D=pageName``.

**prop2**

The top level section path. So if your project belongs under "news/local/breaking," then the prop2 value should be ``news``.

**prop38**

The type of project. Options include: ``articleproject``, ``dataproject``, ``individualarticle``, ``individualgraphic``, ``landingpage``, ``photogalleryproject``, and ``3rd party``.

**prop57**

The same as the prop38 value. So use ``D=c38`` as the value.

**eVar20**

The news organization the project belongs to, so ``chicagotribune`` for Chicago Tribune projects.

**eVar21**

The same as the prop38 value. So use ``D=c38`` as the value.

**eVar34**

The same as the channel value. So use ``D=ch`` as the value.

**eVar35**

The same as the pageName value. So use ``D=pageName`` as the value.

**events**

Leave empty.

Omniture in Tarbell
^^^^^^^^^^^^^^^^^^^
Tarbell's Tribune template blueprint uses the Jinja template tags from the `python-tribune-omniture <https://github.com/newsapps/python-tribune-omniture>`_ package.  These template tags render a JavaScript snippet that initializes Omniture tracking with some of the variables mentioned above.

You'll need to define an ``OMNITURE`` key in the ``DEFAULT_CONTEXT`` variable in ``tarbell_config.py``:: 

        DEFAULT_CONTEXT = {
            'OMNITURE': {
                'domain': 'nfldraft.chicagotribune.com',
                'sitename': 'Chicago Tribune',
                'section': 'sports',
                'subsection': 'bears',
                'subsubsection': '',
                'title': 'NFL Draft',
                'type': 'dataproject',
            }
        }

For more information about the usage of ``python-tribune-omniture``, see https://github.com/newsapps/python-tribune-omniture.

If you want to override the default JavaScript snippet used to initialize Omniture tracking, override the ``omniture`` block defined in the blueprint's ``_base.html`` template::

        {% block omniture %}
        {% omnitag request, OMNITURE, None, title, 'dataproject' %}
        {% endblock omniture %}

If you want to disable Omniture tracking, or load a different script, you can override the ``omniture_scripts`` block::

        {% block omniture_scripts %}
        {% omniscript 'chicagotribune.com', True, True %}
        {% endblock omniture_scripts %}


Debugging
^^^^^^^^^

There is a `debugging bookmarklet available from Adobe <https://marketing.adobe.com/resources/help/en_US/sc/implement/debugger.html>`_.
Install, then load your page and click the Adobe Debugger bookmark. You should see Omniture values populate the fields in the
pop-up window that opens.

Viewing reports
^^^^^^^^^^^^^^^

You can access reports at https://my.omniture.com/.  

You'll need an account (See :ref:`accounts--omniture`).

In the upper-left-hand corner menu, click "SiteCatalyst" and then "SiteCatalyst Reporting".

Clicking on the "ChicagoTribune.com" menu item (it might be labeled something else, but there should always be the "can" icon) will show all available suites.

Reporting for all NGUX is in a suite called "NGUX Chicago Tribune".

Click on "View All Reports" -> "Site Content" -> "Pages"

You can then search for a particular page.

Clicking "Advanced" can help you exclude things from a search result.

Caveats
^^^^^^^

* Reporting is likely a few minutes behind real-time.
* Any views from inside the network don't appear in reporting.

Getting help
^^^^^^^^^^^^

Reach out to data@tribpub.com.


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
