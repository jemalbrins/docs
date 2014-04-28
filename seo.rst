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

The <h1> tag is interpreted by search engines as being the most important descriptive element on a
page, so make sure that you wrap your headline in <h1>s. You can control the size of the <h1> text
itself with CSS, but it's important to use that specific tag.

3. Add alt text to images
-------------------------

This is important for accessibility as well as SEO: alt text on images means that screen readers and
users of devices with slower internet connections can understand the images that they may not be
able to see. So make sure that as many of your images as possible contain descriptive alt text, like
the following:

.. code-block:: html

    <img src="http://chicagotribune.com/rahm.png" alt="Mayor Rahm Emanuel pictured in a scene from
    "Chicagoland," a CNN documentary about the city and its leaders. (CNN)">

4. Use title tags and meta descriptions
---------------------------------------

In order for pages to appear properly in search results, they need a ``<title>`` tag. Keep in mind
that the ``<title>`` tag will often be used as the headline for a page in a set of search results.
Therefore, it should both contain some of the most important keywords for the page in question, and
be able to stand alone in a list of links as an accurate description of the page to which it refers.

The "description" meta tag is helpful both in generating search result snippets, and helping search
engines understand what content and keywords on the page deserve priority. However, don't count on
it being used to directly generate the search result snippet.

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

6. Use Schema.org tags where applicable
---------------------------------------

`Schema.org <http://www.schema.org>`_ tags are a way to add structured data to webpages. They cover
similar territory as meta "description" tags and Open Graph tags, but they're more versatile and
used more prominently by Google. This is all a bit redundant, but different major traffic sources
use slightly different systems, so sadly, some redundancy is necessary.

Schema.org tags can be used for the same purpose as the ``<title>`` and ``og:title`` tag:

.. code-block:: html

    <meta itemprop="name" content="Designed in Chicago, Made in China">

They have an equivalent to the "description" meta tag and ``og:description`` tags:

.. code-block:: html

    <meta itemprop="description" content="In chapter one of a three-part series, &quot;Designed in Chicago, Made in China,&quot; Chicago Tribune architecture critic Blair Kamin and photographer John Kim examine the evolution of some of the most visible symbols of China&#39;s hyper-fast urban growth-its new skyscrapers, many of them Chicago-designed.">

They also have an equivalent to the ``og:image`` tag:

.. code-block:: html

    <meta itemprop="image" content="http://apps.chicagotribune.com/news/chicago-architecture-in-china/img/work-shanghai-og.jpg">

However, Schema.org tags have more uses than just duplicating the functionality of other tags.
They're particularly useful in pointing out elements of a page that we want search engines to pay
particular attention to, like videos and images:

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
    <meta itemprop="articleSection" content="Blue Sky Innovation">

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


Extra-credit SEO tips
---------------------

The above guidelines should be considered essential, unless you have a specific reason not to follow
them. The guidelines that follow are important but not absolutely essential.

8. Put important keywords in title tags
---------------------------------------

This one is tricky. Search engines look for the presence of a word in a title as a signal that a
page is about that word; therefore, it makes sense to feature important, relevant keywords in a
title. However, as a news organization, headlines and titles are important for many more reasons
than just SEO, and search engines look for signs of keyword stuffing - the practice of putting a lot
of arbitrary, nonsensical keywords together in prominent places - as a reason to demote sites that
engage in the practice.

So probably the best advice is: be aware that the word selection in a ``<title>`` tag is important,
and if it's possible to use words that are likely to be search terms for that article, then go
ahead. But don't do this at the expense of accuracy, readability, or anything else that might lead
to a bad user experience.

Put important keywords in image alt tags and meta description tags too, while you're at it
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For the exact same reason, when writing alt text for images and when writing the description meta
tag for a page, keep in mind which keywords you think users would find most relevant, and try to use
them without overusing them.

| Use keywords wisely
| Describe images with them
| Do not overstuff
|

9. Don't use targeted keywords more than 15 times
-------------------------------------------------

As mentioned in the above section on keywords in ``<title>`` tags, search engines will consider the
presence of an unusually large number of occurences of a single word as a sign that a page is
spammy. A good rule of thumb is: make sure that a given keyword doesn't occur more than 15 times on
a page.

Obviously plenty of words will appear constantly on most of our pages; this is more of a
guideline than a hard-and-fast rule. But if you're writing an article about hybrid cars and fuel
cells, and the phrases "hybrid" or "fuel cell" appear more than 15 times, consider using a few
alternate phrases.

10. Make sure the first 70 characters of page titles can stand alone
--------------------------------------------------------------------

Often, search engines, social media clients, RSS readers and other places your site may appear will
truncate titles. The length of title they allow varies, so as a result, our advice is to make sure
that the first 70 characters of your ``<title>`` tag make sense on their own. Don't worry about
whether a word breaks in the middle at character 70; this isn't a precise rule. Just make sure that
the most important and individuating elements of the ``<title>`` tag are at the beginning. For
example, the following would make for a hard-to-understand title in most search result pages:

    Chicago Tribune -- Sports/high school sports -- Mundelein -- Lacrosse team wins state
    championship

It would get truncated to just:

    Chicago Tribune -- Sports/high school sports -- Mundelein -- Lacrosse t

Whereas the following contains the exact same text, but would make much more sense to most users,
wherever they encounter it:

    Lacrosse team wins state championship -- Chicago Tribune -- Sports/high school sports --
    Mundelein

Would become:

    Lacrosse team wins state championship -- Chicago Tribune -- Sports/high

11. Add links to external websites when it makes sense
------------------------------------------------------

Linking to other sites is a pattern that search engines, particularly Google, look for to indicate
good Web citizenship. They reward this behavior by assigning a higher quality score to sites that
practice it, so in this case, doing the right thing is also good for SEO.

Basically, when you're referring to something found online - not just a video or an article, but an
entity with a website - try to include a link to it. The more links, the better, within reason
(typically no more than 1-2 links per sentence, and probably no more than 5 per paragraph, though
those are entirely arbitrary numbers.)

12. Use HTML5 section, header and article tags
----------------------------------------------

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

``<section>`` should be used to wrap the individual components of a page, the ones usually separated
from their surroundings by whitespace. This can be an individual paragraph, a collection of related
paragraphs, an image, a video, etc. How to use this tag in particular is very much open to
interpretation.

Here's an example that uses all three of these tags, as we suggest you use them:

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
        <section>
            <img src="/bulls.png" alt="The Chicago Bulls logo">
        </section>
        <section>
            <p>Just think of this as even more text.</p>
            <p>And many more paragraphs.</p>
        </section>
    </article>
