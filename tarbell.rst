Tarbell
=======

Starting a Chicago Tribune Tarbell project
------------------------------------------

Comprehensive documentation for Tarbell, including `a getting-started tutorial
<https://tarbell.readthedocs.org/en/latest/tutorial.html>`_, is `available here
<https://tarbell.readthedocs.org/en/latest/index.html>`_. This section will outline what you need to
know that's specific to the Chicago Tribune, but it's a good idea to familiarize yourself with the
above documentation if you haven't already.

Begin by installing Tarbell, as outlined `here
<https://tarbell.readthedocs.org/en/latest/install.html>`_. For most users, it's as simple as: ::

    pip install tarbell

Once Tarbell is installed, install the Tribune Tarbell templates: ::

    tarbell install-template https://github.com/newsapps/tarbell-template.git

Finally, to create the project itself: ::

    tarbell newproject

And follow the prompts, as described in more detail `here
<https://tarbell.readthedocs.org/en/latest/tutorial.html>`_.
  
Most of the process involved in setting up a Chicago Tribune Tarbell project is exactly the same 
as a normal Tarbell project, with only a few key differences:

Publishing location
-------------------

You still want to publish to S3, but the buckets to use depend on the specific project. For most 
projects, ``apps.beta.tribapps.com`` is the staging bucket, and ``apps.chicagotribune.com`` is the 
production bucket, but this varies widely from project to project. `Read more about setting up your 
S3 buckets here.
<https://tarbell.readthedocs.org/en/latest/publish.html#configuring-s3-buckets-for-a-project>`_

Templates
---------

When running the ``tarbell newproject`` command, you almost certainly want to use the Tribune
templates. They should have been installed when you ran ``tarbell install-template
https://github.com/newsapps/tarbell-template.git`` above.
