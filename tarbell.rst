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

    tarbell install-template git@tribune.unfuddle.com:tribune/tarbell-base.git

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

Social media
------------

The Tribune Tarbell template comes with social sharing buttons for Twitter, Facebook, Google+ and
Pinterest, as well as metatags that enable social sharing to use descriptions and images specific
to each project. These are all enabled by default, but they rely on a few context variables to be
filled out (`as described in the Tarbell documentation
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
    Default text to appear when a user clicks the Tweet button. Should be 140 characters or fewer,
    and may be replaced or edited by the user before tweeting.

Templates
---------

When running the ``tarbell newproject`` command, you almost certainly want to use the Tribune
templates. They should have been installed when you ran ``tarbell install-template
git@tribune.unfuddle.com:tribune/tarbell-base.git`` above.

Template filters
----------------

The base Tribune template comes with a variety of helpful template filters. The syntax for using
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

Converts newlines into ``<br />`` and wraps each paragraph in ``<p>``.

linebreaksbr
^^^^^^^^^^^^

Converts newlines into ``<br />``.

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
