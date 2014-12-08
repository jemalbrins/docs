Tarbell
=======

Starting a Chicago Tribune Tarbell project
------------------------------------------

Comprehensive documentation for Tarbell, including `a getting-started tutorial
<https://tarbell.readthedocs.org/en/latest/tutorial.html>`_, is `available here
<https://tarbell.readthedocs.org/en/latest/index.html>`_. This section will outline what you need to
know that's specific to the Chicago Tribune, but it's a good idea to familiarize yourself with the
above documentation if you haven't already.

Get set up with Unfuddle
^^^^^^^^^^^^^^^^^^^^^^^^

You will need an Unfuddle account to create project repositories, manage your projects and collaborate 
with other developers. 

Create a new key:

.. code-block:: bash

    ssh-keygen -t rsa

When prompted for a passphrase, hit "enter" or provide a password to use later when interacting
with Unfuddle:

.. code-block:: bash

    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): 
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /home/vagrant/.ssh/id_rsa.
    Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub.
    The key fingerprint is:
    ec:d4:c2:4f:ea:52:73:4e:51:f9:30:fe:40:ab:78:a7 vagrant@precise64
    The key's randomart image is:
    +--[ RSA 2048]----+
    |             .   |
    |            *    |
    |           + =   |
    |       o .. + .  |
    |        S.oo o   |
    |       o+== . .  |
    |       .o*.o     |
    |      ..  E      |
    |       ..        |
    +-----------------+

Now copy your public key:

.. code-block:: bash

    cat ~/.ssh/id_rsa.pub

You'll see your key:

.. code-block:: bash

    ssh-rsa YOUR_SSH_KEY_WILL_BE_HERE

Now, someone from the news applications team will need to create an `Unfuddle <http://tribune.unfuddle.com>`_
account for you. Email the apps team, pasting the contents of your key into the email.

.. note::

    **Apps team / Unfuddle administrators**: Unfuddle doesn't allow administrators to add keys for users. Therefore, to create an account, first create the user with a well known password. Log in as that user and input the new user's public key. Now log back in as an administrative user and send a password reset email to the account you just created.


Install Tarbell
^^^^^^^^^^^^^^^

Install Tarbell, as outlined `here
<https://tarbell.readthedocs.org/en/latest/install.html>`__. For most users, it's as simple as: ::

    pip install tarbell

Once Tarbell is installed, install the Tribune Tarbell templates: ::

    tarbell install-template git@tribune.unfuddle.com:tribune/tarbell-base.git

Finally, to create the project itself: ::

    tarbell newproject

And follow the prompts, as described in more detail `here
<https://tarbell.readthedocs.org/en/latest/tutorial.html>`__.
  
Most of the process involved in setting up a Chicago Tribune Tarbell project is exactly the same 
as a normal Tarbell project, with only a few key differences:

Ticket creation
---------------

Tarbell will ask if you would like to use Unfuddle to manage your project. You can create a repo in Unfuddle
or create tickets in Unfuddle (or both). The tickets will be automatically generated for you based on the
tickets we normally find helpful when dealing with projects. When you do this, Tarbell will ask you
what your project ID is. You can find this by looking at the URL of your project in Unfuddle, which should
be something like this::

  https://tribune.unfuddle.com/a#/projects/6/ticket_reports/411

The number after ``projects``, in this case, ``6``, is your project ID.

Publishing location
-------------------

You still want to publish to S3, but the buckets to use depend on the specific project. For most 
projects, ``apps.beta.tribapps.com`` is the staging bucket, and ``apps.chicagotribune.com`` is the 
production bucket, but this varies widely from project to project. `Read more about setting up your 
S3 buckets here.
<https://tarbell.readthedocs.org/en/latest/publish.html#configuring-s3-buckets-for-a-project>`_

Ads
---

For more on how to use ads in Tribune projects, `see our Tarbell example in the ads documentation 
<ads.html#example-using-tarbell>`_ or `see our complete ads documentation <ads.html>`_.

Comments
--------

For more on how to use comments in Tribune projects, `see our Tarbell example in the comments 
documentation <comments.html#example-using-tarbell>`_ or `see our complete comments documentation 
<comments.html>`_.

Paywall
-------

For more on how to use the paywall in Tribune projects, `see our Tarbell example in the paywall 
documentation <paywall.html#example-using-tarbell>`_ or `see our complete paywall documentation 
<paywall.html>`_.

Social media
------------

The Tribune Tarbell template comes with social sharing buttons for Twitter, Facebook, Google+ and
Pinterest, as well as metatags that enable social sharing to use descriptions and images specific
to each project. **Social media buttons will not appear in the project header if the og_description, 
og_image and twitter_description are not filled out in the Google spreadsheet** (`or default context 
<https://tarbell.readthedocs.org/en/latest/build.html#using-context-variables>`_). 

og_description
    Text to be used as a descriptive snippet in Facebook and Pinterest sharing. Should be 200 
    characters or fewer.

og_image
    Image to be used as a thumbnail to associate with this page in Facebook and Pinterest 
    sharing.    

title
    Text that will appear in the nav bar at the top of the page, and appear in Facebook sharing as
    the title of the page.

twitter_description
    Default text to appear when a user clicks the Tweet button. Should be **117 characters or fewer** (to
    accomodate the link as well as the text), and may be replaced or edited by the user before tweeting.

.. note::

    Facebook has a `debug tool <https://developers.facebook.com/tools/debug/>`_ and Google+ has a `structured data testing tool <http://www.google.com/webmasters/tools/richsnippets>`_, both of which can be used to find and help fix errors you encounter with these tags.

Templates
---------

When running the ``tarbell newproject`` command, you almost certainly want to use the Tribune
templates. They should have been installed when you ran ``tarbell install-template
git@tribune.unfuddle.com:tribune/tarbell-base.git`` above.

Macros
------

Macros work a little differently in Tarbell than they do in the Jinja documentation. The Tribune template includes all
its default macros in ``_macros.html``. On line one, ``_base.html`` imports the macros file and gives it access to any 
`context variables <http://tarbell.readthedocs.org/en/0.9-beta6/build.html#using-context-variables>`_ you've defined. If your
context variables are in a Google spreadsheet, you can access those values by name. For instance, if you have a Brightcove video
to embed in your page, all you need to enter in the spreadsheet is the video ID number. Say you give this number a key of 
"project_video_id" in the spreadsheet. All you need to do to embed the video is call the macro in your template like so: ::

{{ macros.video(project_video_id) }}

Note that if your project is not in the default ``values`` spreadsheet, you will need to use ``project_video_id.value``.

Macros exist for NDN video, photo galleries, DocumentCloud views and more. Check out all of the built-in macros in ``_macros.html``.

Template filters
----------------

The Tribune template comes with a variety of helpful template filters. The syntax for using
them is generally as follows: ::

    <p>{{ some_text|foo }}</p>

This will apply the ``foo`` filter to the context variable ``some_text``. Much more on how filters 
in general work is available `in the Jinja documentation 
<http://jinja.pocoo.org/docs/templates/#filters>`_.

Template filters: formatting
----------------------------

These filters all modify the formatting of text passed to them.

br_to_p
^^^^^^^

Converts text where paragraphs are separated by two ``<br>`` tags to text where the paragraphs are 
wrapped by ``<p>`` tags.

drop_cap
^^^^^^^^

Applies ``<span class="drop-cap">`` to the first character in ``intro_text``. The Tribune template 
base CSS contains some styling for the ``drop-cap`` class.

format_date
^^^^^^^^^^^

Returns a properly-formatted date string, such as Mar. 21, 2014, when given an
arbitrarily-formatted date string, such as 3-21-2014. The filter accepts two additional arguments:
a string containing a `format to convert the original string to
<https://docs.python.org/2/library/time.html#time.strftime>`_, and a timezone string (such as 
``EST``). For instance, to convert a date string to AP style, the filter's default behavior: ::

    {{ date_string|format_date }}

To convert the same string to `month/day/4-digit year` format in Central Standard Time: ::

    {{ date_string|format_date('%m/%d/%Y', 'CST') }}

get_paragraphs
^^^^^^^^^^^^^^

Takes a block of text and returns a list of paragraphs. Only works if paragraphs are denoted by
``<p>`` tags and not double ``<br>``. Use ``br_to_p`` to convert text with double ``<br>`` to 
``<p>``-wrapped paragraphs.

int_commas
^^^^^^^^^^

Adds commas at every thousandth for integers, turning `11000` to `11,000`.

linebreaks
^^^^^^^^^^

Returns an array of paragraphs, each one of which is wrapped in ``<p>`` tags.
.

linebreaksbr
^^^^^^^^^^^^

Returns an array of paragraphs, sans ``<p>`` tags. Use when you want to add a class to ``<p>`` tags
or wrap your content with other tags.

markdown
^^^^^^^^

Returns a `Markdown-formatted <http://daringfireball.net/projects/markdown/>`_ version of the given
string.

replace_windows_linebreaks
^^^^^^^^^^^^^^^^^^^^^^^^^^

Replaces all Windows/MS-style linebreak characters (``\r``) with more widely-supported UNIX-style 
``\n``.

section_heads
^^^^^^^^^^^^^

Replaces ``<p><b>`` wrapping around text with ``<h4 class="section-head">``. The Tribune template 
base CSS contains some styling for the ``section-head`` class.

strip_p
^^^^^^^

Removes enclosing ``<p>`` and ``</p>`` tags.

strong_to_b
^^^^^^^^^^^

Replaces enclosing ``<strong>`` and ``</strong>`` with ``<p><b>``.

urlencode
^^^^^^^^^

Returns a "safe" version of the given string, encoded in UTF8 and sanitized for use in URLs.

wrap_p
^^^^^^

Adds enclosing ``<p>`` and ``</p>`` tags.

Template filters: P2P
---------------------

These filters return P2P content when given a slug or content item dictionary.

fancy_item
^^^^^^^^^^

Takes either a slug or a content item dictionary and returns a content item dictionary that 
includes all related items.

get_p2p_content
^^^^^^^^^^^^^^^

DEPRECATED: Use context function get_p2p_content_item instead.
