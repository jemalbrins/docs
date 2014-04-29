12 Surprising Tips to Get Great SEO
===================================

There's no one-size-fits-all recipe for SEO optimization, but over time we've learned some tips and
rules that are reasonably applicable to most Tribune projects. This page is heavily based on the
excellent `Moz on-page grader tool <https://moz.com/researchtools/on-page-grader>`_ (ask the SEO
team if you'd like to use it with the Tribune account).

Troubleshooting tools and other places to look for information
--------------------------------------------------------------

There are a vast array of resources online to help you with every aspect of SEO, but here are a few
of the most useful that we've found:

Google Webmaster Tools
    `Google Webmaster Tools <https://www.google.com/webmasters/tools/home?hl=en>`_ are the best
    place to start when looking to troubleshoot existing websites. Make sure you get verified as the
    owner of the site you're investigating, or talk to the SEO team for credentials to an
    already-verified account. This will tell you about any problems Google has had crawling content
    for the site in question.

Google Structured Data Testing Tool
    The `Structured Data Testing Tool <https://www.google.com/webmasters/tools/richsnippets>`_ will
    tell you how a URL will look in search results, and help you diagnose any issues with structured
    data that Google supports to improve how a search result appears. This site also contains a
    `Structured Data Markup Helper <https://www.google.com/webmasters/markup-helper/?hl=en>`_
    designed to help you analyze and add structured data to an existing page.

Guide to generating rich snippets in search engine results
    `SEO Gadget's guide
    <http://seogadget.com/micro-data-schema-org-guide-to-generating-rich-snippets/>`_ to structured
    data is a helpful, in-depth tutorial that explains what structured data is and how to use it in
    more detail than this documentation is capable of doing.

1. Put page content in HTML, don't load it with Javascript
----------------------------------------------------------

Most search engines at least claim to be unable to process text hidden in Javascript, and prefer
that all page content is present in the HTML of a page itself when it first loads. This might seem
trivially obvious, but there are projects that load all content dynamically - for instance, our
`shootings <http://crime.chicagotribune.com/chicago/shootings>`_ and `homicides
<http://crime.chicagotribune.com/chicago/homicides>`_ pages put almost no text in the initial HTML
of the page, and instead load all their content via Javascript. This works for dynamically-generated
pages, and pages for which we're less concerned about ranking for specific terms. In general, try to
avoid putting content in Javascript, unless you have a good reason to do so.

2. Wrap headlines in H1 tags
----------------------------

The <h1> tag is interpreted by search engines as being one of the most important descriptive
elements on a page (second only to the <title> tag), so make sure that you wrap your headline in
<h1>s. You can control the size of the <h1> text itself with CSS, but it's important to use that
specific tag.

3. Add alt text to images
-------------------------

This is important for accessibility as well as SEO: alt text on images means that screen readers and
users of devices with slower internet connections can understand the images that they may not be
able to see. So make sure that as many of your images as possible contain descriptive alt text, like
the following:

.. code-block:: html

    <img src="http://chicagotribune.com/rahm.png" alt="Mayor Rahm Emanuel in a scene from
    &ldquo;Chicagoland&rdquo;">

4. Use title tags and meta descriptions
---------------------------------------

In order for pages to appear properly in search results, they need a ``<title>`` tag. Keep in mind
that the ``<title>`` tag will often be used as the headline for a page in a set of search results.
Therefore, it should both contain some of the most important keywords for the page in question, and
be able to stand alone in a list of links as an accurate description of the page to which it refers.

The title should be no longer than 70 characters, and there should be no duplicate titles across the
site. Important keywords should appear earlier in the title than less-important keywords, if at all
possible. For more information on the ``<title>`` tag, check out `this excellent Moz walkthrough
<http://moz.com/learn/seo/title-tag>`_.

The "description" meta tag is helpful both in generating search result snippets, and helping search
engines understand what content and keywords on the page deserve priority. However, don't count on
it being used to directly generate the search result snippet. The description text should be no
longer than 156 characters.

.. code-block:: html

    <title>Chicago Under the Gun -- Chicago Tribune</title>
    <meta name="description">Chicago Under the Gun: Tribune photographers chronicle the physical and
    emotional toll of Chicago&#39;s violent crimes in this special visual report</meta>

You may have noticed the ``&#39;`` character in the description, in place of the usual ``'``
character. This is the `HTML character code <http://www.ascii.cl/htmlcodes.htm>`_ for a single
quote; we recommend replacing all quotation marks, and pretty much all special characters (outside
of periods, question marks, colons, semicolons and exclamation points) with their HTML character code
equivalents. This prevents search engine results from displaying strange characters in their result
snippets.

5. Add Open Graph tags to pages
-------------------------------

`Open Graph tags <http://ogp.me/>`_ were initially created by Facebook to give websites more control
over how links to their pages appeared in users' news feeds. They still serve that role, for
Facebook and other sites, but they've also become important sources of metadata for search engines
over time as well.

Open Graph requires, at a minimum, the following 4 tags to be specified:

``og:title``
    Title of the page
``og:type``
    Type of page; for our purposes, this should usually be ``article`` or occasionally, ``website``
``og:image``
    URL for an image to associate with this page
``og:url``
    Canonical URL for this page

Additionally, we often use the ``og:description`` tag instead of the "description" meta tag, and
that seems to work well.

Here's an example:

.. code-block:: html

    <meta property="og:url" content="http://graphics.chicagotribune.com/under-the-gun/index.html" />
    <meta property="og:title" content="Chicago Under the Gun" />
    <meta property="og:type" content="article" />
    <meta property="og:description" content="Chicago Under the Gun: Tribune photographers chronicle the physical and emotional toll of Chicago&#39;s violent crimes in this special visual report" />
    <meta property="og:image" content="http://graphics.chicagotribune.com/under-the-gun/img/under-the-gun.jpg?v12" />

6. Use Schema.org tags
----------------------

`Schema.org <http://www.schema.org>`_ tags are a way to add structured data to webpages, primarily
for use by search engines to help them understand the content they crawl as they scan the web. They
allow search engines to look inside pages and understand more of the actual content they see,
allowing that content to appear in more places and be used for more purposes.

Schema.org tags can tell search engines that they're encountering a specific layout element, like a
video or photo, and give that layout element attributes like a name:

.. code-block:: html

    <div class="trib-media" itemscope itemtype="http://schema.org/VideoObject">
        <aside>
            <h3 class="china-section-head video-head" itemprop="name">Shanghai&#39;s rise</h3>
            <div class="video-wrapper">
                <iframe src="//player.vimeo.com/video/86333422" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
            </div>
        </aside>
    </div>

We also use Schema.org tags to tell search engines who created our content, and what section it
belongs to:

.. code-block:: html

    <span itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
        <meta itemprop="name" content="Chicago Tribune">
    </span>
    <article itemscope itemtype="http://schema.org/Article">
        <meta itemprop="articleSection" content="Blue Sky Innovation">
        <h1 itemprop="headline">This is a post about nothing</h1>
        <div itemprop="articleBody">
            <p>...</p>
        </div>
    </article>

Also, note that the above example embedded Schema.org tags in an HTML5 element (the `article
element <#use-html5-markup-tags>`_) as well as the ``<h1>`` and ``<div>`` elements. It's often more
efficient to add Schema.org markup directly to existing page elements. That way, search engines are
learning the semantic meaning of our pages in almost the exact same fashion that users are reading
them; there's less to update and less work to ensure consistency.
    
.. note::
    
    Question for editors: should we include more detail from `Taylor's Schema.org guide
    <https://docs.google.com/document/d/1wkO8ctjkQAbCJYkKBuHh2X9XXZYUhaBd4ZBamSnDBPo/edit>`_? Should
    that be a separate page/section in these docs?

7. Make sure pages have canonical URLs
--------------------------------------

Canonical URLs allow us to tell search engines which page to send users to, in cases where several
different copies of the page exist. For instance, one slug in P2P might be published to the
business section of the Chicago Tribune and the LA Times, as well as the special Blue Sky section of
the Tribune. We typically want only one version of those three pages to receive traffic from search
engines and social media, and the ``rel=canonical`` meta tag allows us to control that. It can also
help prevent search engines from penalizing us for having multiple duplicate pages. In the above
example, let's say that the slug is "chi-bs-canonicals-are-great", and we have copies of it at the
following URLs:

|    http://www.chicagotribune.com/business/chi-bs-canonicals-are-great,0,0.story
|    http://www.latimes.com/business/chi-bs-canonicals-are-great,0,0.story
|    http://bluesky.chicagotribune.com/originals/chi-bs-canonicals-are-great,0,0.story
|

In this case, we want the Blue Sky page to receive all the traffic, so we would add the following
tag to the ``<head>`` section of all three pages (not just the Blue Sky page; it must be added
everywhere that could be considered a duplicate):

.. code-block:: html

    <link rel="canonical" href="http://bluesky.chicagotribune.com/originals/chi-bs-canonicals-are-great,0,0.story" />

8. Put important keywords in image alt tags and meta description tags too
-------------------------------------------------------------------------

When writing alt text for images and when writing the description meta tag for a page, keep in mind
which keywords you think users would find most relevant, and try to use them without overusing them.

9. Add links to external websites when it makes sense
------------------------------------------------------

Linking to other sites is a pattern that search engines, particularly Google, look for to indicate
good Web citizenship. They reward this behavior by assigning a higher quality score to sites that
practice it, so in this case, doing the right thing is also good for SEO.

However, linking to another webpage will cause search engines to assign some value to that page as
well. In some cases where we don't wish for that to occur - for instance, when a link appears as
part of some boilerplate, like a login link - use the ``rel="nofollow"`` attribute, to tell search
engines not to follow the link:

.. code-block:: html

    <a href="/signup.html" rel="nofollow">Sign up here</a>

10. Use HTML5 markup tags
-------------------------

The `HTML5 standard <http://www.w3.org/TR/html5/>`_ offers a few new tags that make the layout of
our sites easier for search engines to understand, which in turn will make it easier for them to
score and rank our content effectively.

``<article>`` should be used to wrap an entire piece of content that shouldn't be broken up. The
`spec <http://www.w3.org/TR/html5/sections.html#the-section-element>`_ notes that the <article>
element should be used "when it would make sense to syndicate the contents of the element." Another
way to think about that is, "What is the smallest portion of this page that would make sense to
appear as an individual entry in an RSS reader, or as a Facebook post?"

``<header>`` should be used to wrap the headline, byline and dateline of an article or post,
separating them from the contents of the article or post itself.

``<footer>`` should be used to wrap the elements that typically appear at the bottom of the page,
like copyright and contact info.

``<section>`` should be used to wrap the individual components of a page, the ones usually separated
from their surroundings by whitespace. This can be an individual paragraph, a collection of related
paragraphs, an image, a video, etc. How to use this tag in particular is very much open to
interpretation.

``<aside>`` should be used to wrap layout elements that aren't part of the main body of the page,
but are tangentially related to it, like embedded videos and photos or pull quotes.

Here's an example that uses all five of these tags, as we suggest you use them:

.. code-block:: html

    <article>
        <header>
            <h1>Why the Bulls are the best team ever</h1>
            <h3>By Michael Jordan, 4/25/2014</h3>
        </header>
        <section>
            <p>Who doesn't love the best team in basketball?</p>
            <p>This is a full paragraph. Just trust me.</p>
        </section>
        <aside>
            <p>"Just trust me"</p>
        </aside>
        <section>
            <p>Just think of this as even more text.</p>
            <p>And many more paragraphs.</p>
        </section>
    </article>
    <footer>
        <p>Copyright 2014, Chicago Tribune</p>
        <p>435 N. Michigan, Chicago, IL, 60611</p>
    </footer>

.. note::
    
    Question for editors: should we include the schema.org tags in this example as well, or would
    that distract from the HTML5 stuff?
