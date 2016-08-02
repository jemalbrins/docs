Tarbell/P2P/Command line cheat sheet
====================================

*UPDATED: June 2016*

This guide is intended to help those who need a quick mental refresher when launching new projects and otherwise adapting old workflows (read: manually coding lots of things) into the tarbell-based workflow. There will be plenty of exceptions to the rules of thumb layed out below, but they are good starting points until you develop a deeper understanding of the tools you are using.


.. note::
  
  **About code and command line samples**

  At times, these docs will provide sample commands and code snippets in a block of text styled ``like this``. In general, you can use them directly. On occasion, you will need to add some relevant information, such as a Git url. In these instances, the example will include a portion bracketed with carats ``<like this>``. These should be replaced with whatever information is needed. An example::
    
    tarbell install <git@repo_url>

  How you should type it:: 

    tarbell install  git@tribune.unfuddle.com:tribune/python-tribune-viztools.git

  In other instances, a command or code snippet might include a URL path. In these instances, the examples will include ``path/to/asset`` which should be replaced with the actual url. An example::

    cd path/to/project

  How you should type it::

    cd ~/code/my_project

.. note::

    **Make sure the tools library is up-to-date**

    While Tarbell will pull the freshest possible copy of the blueprint each time you start a new project, it won't automatically install the newest version of our :ref:`tarbell-tools-library`.

    To make sure the tools library is up-to-date, run this command::

        pip install --upgrade git+https://tribune.unfuddle.com/git/tribune_python-tribune-viztools/@0.4.1#egg=tribune_viztools

Starting new project (with P2P template)
----------------------------------------

   1. **Create the tarbell project.** ``tarbell newproject <projectname>`` will start a new project and begin the process of configuring it.
           a. Choose the **Tribune template (p2p).**
           #. Tarbell will ask about installing **requirements**. Unless you're told otherwise by a project collaborator, you don't need to install requirements when asked. 
           #. Tarbell will ask about using **Unfuddle**. You should. The default project of **60** is the graphics projects and should be used in nearly all cases.
           #. Yes, create a **repo.**
           #. You don't need to create tickets. You should already have created one before starting this process. In fact, the repo address from the previous step should be added to your ticket. Get the address `here <https://tribune.unfuddle.com/a#/repositories>`_.
   #. **Change directory to your project directory.** This is the directory that is reported at the end of the ``tarbell newproject`` output.  For example: ``cd ~/tarbell/your-new-project``. 
   #. **Install project build dependencies.** After changing to your project directory, run ``npm install``. This should be done right away after staring a new project. This let's you use the tools we need to turn SASS into CSS, bundle and minify JavaScript and do other very fun things.
   #. **Share your project spreadsheet.** Your spreadsheet should be shared automatically with the team, but just make sure. It should be in Google Drive/Trib Docs/Data Team/Tarbell projects

.. note::
  
  **Working on a Tarbell project**

  You'll want to have three tabs open in your terminal. It doesn't matter which order you do these things (or which tabs they are). You just need them open. For each of them, change into the project directory (``cd``)

  - **Tab 1:** Run ``tarbell serve`` and leave the tab open. Now you can view your project at `localhost:5000 <https://localhost:5000>`_. As long as this tab is open, you have a web server.
  - **Tab 2:** Run ``npm run build && npm run watch`` and leave the tab open. Now any time you make a change to your sass, new css is generated. This is true for javascript bundling and any other tasks you've got running with build tools such as npm, grunt or gulp.
  - **Tab 3:** This is the tab you use to make git commits or any other typing.

.. note::

        Does running ``npm run build`` or ``npm run watch`` raise an error like this?::

             npm ERR! Darwin 14.5.0
             npm ERR! argv "/usr/local/Cellar/node/5.4.0/bin/node" "/usr/local/bin/npm" "run" "build"
             npm ERR! node v5.4.0
             npm ERR! npm  v3.3.12
             npm ERR! missing script: build

        The project was probably created before we switched to npm scripts.  To update your ``package.json`` and fix this, see :ref:`tarbell-updating-to-npm-scripts`.     


Tarbell
-------
`Tarbell documentation <https://tarbell.readthedocs.org/en/latest/>`_
   
   - Starting a new project:
      1. ``tarbell newproject <projectname>``
      #. ``cd /path/to/<projectname>``
      #. ``npm install``

   - Where does the content go? In the **_content.html** it goes between the content tags::
      
      {% block content %}
      {% endblock content %}

   - Where do your scripts go? Links to scripts go in the **library_scripts** block::

      {% block library_scripts %}
         <script></script>
      {% endblock %}

   - Link to stylesheets, including the one you're making, get added to the scripts array::

      {% block scripts %}
         <script>
         (function(document) {
           // Note the quote marks surrounding each link 
           // and the commas seperating them.
           var CSS = [
             "//{{ ROOT_URL }}/css/styles.css",
             "//{{ ROOT_URL }}/css/another_styles.css",
             "//{{ ROOT_URL }}/css/yet_another_styles.css"
           ];    
           CSS.forEach(function(url) {
             var link = document.createElement('link');
             link.setAttribute('rel', 'stylesheet');
             link.setAttribute('href', url);
             document.head.appendChild(link);
           });
         })(document);    
         </script>
      {% endblock scripts %}


    .. note::

         When linking to things like images and stylesheets, your url should look like this: ``http://{{ ROOT_URL }}/path/to/image/or/other/asset.jpg``. The ``ROOT_URL`` variable makes sure that your page can reference the assets regardless of whether you are running it locally or on P2P.

   - Where do your hand-written scripts go? Litte scripts, such as a dataTables or clicker initilization can go in the **scripts** block::

      {% block scripts %}
         <script>
            // Code here
         </script>
      {% endblock %}
   - Helpful Tarbell commands for the command line
      - ``tarbell`` On it's own, this command brings up a more detailed list of possible commands
      - ``tarbell install <git@repo_url>`` Downloads and installs tarbell projects locally
      - ``tarbell spreadsheet`` Automatically opens an associated spreadsheet in a new browser tab.
      - ``tarbell publish`` or ``tarbell publish staging`` Whether publishing to P2P or off platform, this makes your project viewable in the tower at `apps.beta.tribapps.com <https://apps.beta.tribapps.com>`_
      - ``tarbell publish production`` If publishing to P2P, this uploads your site into the designated P2P slug. Otherwise, if ppublishing off platform, this makes your project viewable to the whole world (and Google) at your production URL, probably `graphics.chicagotribune.com <http://graphics.chicagotribune.com>`_

Jinja
-----
Jinja is the templating language you will use in Tarbell projects. It's very handy. The `Jinja documentation <http://jinja.pocoo.org/docs/dev/>`_ is very straightforward and accessible. You'll almost certainly need a `for loop <http://jinja.pocoo.org/docs/dev/templates/#list-of-control-structures>`_ and maybe a couple `if statements <http://jinja.pocoo.org/docs/dev/templates/#if>`_ 
Also, remember what this syntax means:
   
   - To ouput the value of a variable, use double curly braces::
      
      {{ This is the value of a variable }}

   - To have Jinja *do something*, use a percent sign::

      {% This is a command %}

   - Jinja comments will not show up in your rendered pages. They are a good place to stash notes instead of HTML comments (``<!-- -->``). The readers don't need to see that. Comments are wrapped with a hashtag::

      {# This is a comment #}


Sass
----

Sass is an expansion/improvement on old-school styles `Sass documentation <http://sass-lang.com/>`_ Among it's useful features:

   - ``$variables`` Must begin with a **$.**
   - ``@import`` Is how you combine sass files into a single document.
   - ``@include`` Is how you use a mixin.

Bash/Command line hints
-----------------------

Here is a good tutorial on command line stuff. Some basics you'll probably want:

   - ``ls <path/to/directory>`` Lists all the files in a given directory
   - ``pwd`` Outputs your present working directory
   - ``cd <path/to/target/directory>`` changes directory to the given path 
   - ``subl <path/to/target/directory>`` If configured properly, will open the contents of the given file/directory in sublime
   - ``~`` is the shorthand version of the logged-in user's root directory.

Node/NPM
--------

   - ``npm run build``: Makes sass into css. It also does lots of other things.
   - ``npm run watch``: Run this in it's own tab and it will automatically run your build tools when it detects changes to a file. 

Git 
---

`Git documentation <https://git-scm.com/doc>`_

   - ``git status`` See what uncommitted changes exist in a directory
   - ``git add`` Tell git to watch a file or files for changes
   - ``git commit`` Tell git that the changes you made should be kept.
   - ``git pull`` Brings changes from elsewhere onto your machine. **Never push before you pull.**
   - ``git push`` Overwrites content elsewhere with your changes. **Never push before you pull.**



JS/CSS tools
------------
*Many of these will be temporary as we flesh out our tarbell blueprint and related tools. In the near future, you will download some of these components using node/npm and include them in your project as needed.*

- base css (can be accessed via sass)
   `https://s3.amazonaws.com/media.apps.chicagotribune.com/graphics-toolbox/tribuneBase/tribune-graphics-base-1.3.css`

- skeleton (can also be used via sass)
      `https://s3.amazonaws.com/media.apps.chicagotribune.com/graphics-toolbox/skeleton.css`

- makePanels
   - `https://s3.amazonaws.com/media.apps.chicagotribune.com/graphics-toolbox/makePanels/1.4/jquery.makePanels.1.4.css`

   - `<script type='text/javascript' src="https://s3.amazonaws.com/media.apps.chicagotribune.com/graphics-toolbox/makePanels/1.4/jquery.makePanels.1.4.min.js"></script>`
   
   - Initialize makePanels.js::

      $('#target').makePanels({
         type:"buttons",    /* Options are "none", "buttons" or "dropdown" */
         transitionSpeed: 0, /* 0=instant, 1000 = 1 second */
         showForwardBackButtons:false, /* duh! */
         alignNav:"left", /* Also can be "left" */
         matchPanelHeightsToggle:false, /* This will make all panels the same height */
         showFirst:"" // The ID of the panel which should be visible on init
      });

- dataTables
   - <script type='text/javascript' src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>
   - <script type='text/javascript' src="http://cdn.datatables.net/responsive/1.0.1/js/dataTables.responsive.js"></script>  
   - https://s3.amazonaws.com/media.apps.chicagotribune.com/graphics-toolbox/dataTables/tribune-datatables.min.css
   - Initialize dataTabels.js (This can easily become very complicated, but this is a very basic use)::

      var table = $('#targetTable').DataTable({
         "paging": false, /* If true, the table will only show a small number of rows at a time */
         "lengthMenu": [[50,100,500,-1], [50, 100,500,"All"]], /* if paging=true, then this controls the options for how many to show on a single page ... [ options ][ menu labels ]*/
         "searching": true, /* should the user be allowed to filter the table? */
         "ordering": true, /* Should user be allowed to reorder? */
         "order": [[ 4, "desc" ]], /* By which column should the table be ordered at first */
         "responsive": true /* Should the table hide columns in the child row? */
      });  
- jQuery
   `<script type='text/javascript' src="http://code.jquery.com/jquery-2.1.1.min.js"></script>`

    
