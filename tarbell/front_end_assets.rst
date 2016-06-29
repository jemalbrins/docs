.. _tarbell-front-end-assets:

Building front end assets
-------------------------

Our Tarbell blueprints include tools for managing JavaScript and CSS dependencies, compiling these assets and bundling them.

We use `npm <https://www.npmjs.com/>`_ to install the build tools and JavaScript libraries for a project, so run this command to get all the dependencies:

    npm install

You generally only need to do this once, when you first create a project, or clone its repository.  However, if someone updates the dependencies, you might need to run it again.    


To build static assets in a project run:

    npm run build

To start watching JavaScript and Sass files for changes and recompile them as you work, run:

    npm run build && npm run watch

We run ``npm run build`` first to make sure any previous changes are incorporated in the build before we start watching. In most shells ``&&`` means "run the following command only if the preceding command succeeds".  

.. _tarbell-updating-to-npm-scripts:

Updating your project to use npm scripts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We use `npm scripts <https://docs.npmjs.com/cli/run-script>`_ to run our build tools.  The actual heavy lifting is done by `Grunt <http://gruntjs.com/>`_, but it's very possible that this will change in the near future since npm scripts provide greater flexibility over build tools like Grunt or Gulp. This article, `"Why npm scripts?" <https://css-tricks.com/why-npm-scripts/>`_ describes some of the reasons for this approach.

Prior to the end of June 2016, we just straight up used Grunt to build front-end assets.  If you want to update an old project so you can use ``npm run build`` and ``npm run watch`` for consistency, edit your project's package.json so the ``scripts`` section includes the entries for ``build`` and ``watch``.

.. code-block:: json 

  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "build": "grunt",
    "watch": "grunt watch"
  },


