.. _tarbell-tools-library:

Tools library
-------------

Tarbell has a concept of `Blueprints <http://tarbell.readthedocs.io/en/latest/blueprints.html/>`_ that can be used to set up boilerplate for common types of projects.  One day, we hope to have blueprints for things like timelines, locator maps, "if you go" stories, etc.  Much of what goes on in our blueprints, such as initializing the JavaScript/CSS build scripts, or custom Jinja filters,  will be the same in all our blueprints.  Rather than replicating code in each of the Blueprints, we've factored the common functionality out into a separate package named ``tribune_viztools``. 


You can view the repository and the README with installation instructions `here <https://tribune.unfuddle.com/a#/projects/6/repositories/437/browse>`_.
