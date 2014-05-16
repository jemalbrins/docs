Analytics
=========

Omniture
--------

The Omniture library we use lives here: https://gist.github.com/rnagle/9787649

Omniture.js has no hard dependencies. It uses jQuery on some Tribune sites where ``registration.js`` is loaded, in which case ``registration.js`` takes care of loading jQuery for us.

All you need to do is source omniture.js on your page::

    <script type="text/javascript" src="/path/to/omniture.js"></script>

Configuration
^^^^^^^^^^^^^

Omniture.js creates a singleton ``omniture`` object attached to the browser's ``window``. To start tracking page views, call ``omniture.init`` like so::

    omniture.init('tribglobaldev', {
      pageName:  'Chicago Tribune / archives / print - edition.',
      server:    'www.chicagotribune.com',
      channel:   'Chicago Tribune:archives',
      prop38:    'printedition',
      prop64:    'mm-dd-yyyy',
      hier1:     'Chicago Tribune:archives:print',
      hier2:     'archives:print',
      hier4:     'archives:print',
      eVar20:    'Chicago Tribune',
      eVar21:    'printedition'
    });

``omniture.init`` takes two arguments -- account and parameters. The account is equivalent to the s_account variable set in the traditional Omniture tag. The parameters arg is a javascript object where Omniture variable names are the keys. Where with a traditional Omniture tag you would set ``s.server = 'www.chicagotribune.com'`` with omniture.js you instead do::

    omniture.init('tribglobaldev', { server: 'www.chicagotribune.com' });

Incrementing page views
^^^^^^^^^^^^^^^^^^^^^^^

When you call ``omniture.init`` the library will register a single page view.

If you want to increment the page view count, say if you're cycling through photos in a gallery and want each image to be counted individually, you can::

    var photo_number = 12;
    omniture.set_var('prop37', 'Photo ' + photo_number);
    omniture.page_view();

Debugging
^^^^^^^^^

For debugging purposes, you can determine how many page views have been recorded by inspecting ``omniture.page_views_recorded``.

There is a `debugging bookmarklet available from Adobe <http://blogs.adobe.com/digitalmarketing/analytics/meet-the-new-digitalpulse-debugger/>`_ as well.
