Overview
========

Our servers are hosted using `Amazon's Elastic Compute Cloud (EC2) <https://aws.amazon.com/ec2/>`_ service and can be managed through the AWS console.

Connecting
----------

You can connect to our servers `using SSH <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html>`_.  You will need to login as the ``newsapps`` user and use the private key file (currently ``frakkingtoasters.pem``).  You should get this file from another member of the team.  It will also be helpful if you get a copy of an SSH configuration file that creates aliases for the servers so you don't have to remember or look up the full public DNS name for our instances.

Clusters and types
------------------

Our server instances are organized into clusters and types.  Both of these are implemented through `tags of the EC2 instances <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html>`_ which can be viewed and configured through the AWS console. The cluster and type tags are primarily used to automate deployment using our `deploy-tools <https://github.com/newsapps/deploy-tools>`_, but understanding how we organize our instances is useful for knowing which code runs on which server.

Clusters
^^^^^^^^

We have two main clusters for deploying news applications.  There are other clusters for things like the Wordpress sites that our group used to manage. Don't worry about those.  The two clusters for news applications are ``production`` and ``staging``.  As the names suggest, ``production`` is for public-facing, published news applications.  ``staging`` is for beta versions, internal review, and integration testing.

Types
^^^^^

Within a cluster, each instance plays one or more roles:

* app - Runs a dynamic web application. This usually written using Django or Flask.
* worker - Runs tasks initiated by the app server, usually managed by a task queue such as Celery.   
* admin - Runs scheduled tasks (usually cron jobs) for data loading/processing.

production
^^^^^^^^^^

.. note::
  
  **For the most up-to-date information, see the AWS console**

    
These hosts are part of the production cluster (``django-production``).

* app1.django (app, worker)
* app2.django (app)  
* bfcron.django (admin)  

staging
^^^^^^^

.. note::
  
  **For the most up-to-date information, see the AWS console**

These hosts are part of the staging cluster (``django-staging``).

* django-app1.beta (app, worker, admin)
* django-app2.beta (app)  
