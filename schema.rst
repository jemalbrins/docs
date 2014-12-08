Using Schema.org Markup & Microdata
===================================

Shout out to Taylor Brown for putting these docs together!

`Schema.org
<http://www.schema.org/>`__ tags are a way to add structured data to webpages, primarily for use by
search engines to help them understand content and use it for more purposes. These are necessary for
rich snippets in search engines, such as these: 

.. image:: https://www.google.com/help/hc/images/webmasters/webmasters_99170_rsreview_en.png

Rich snippets don't have a direct effect on rankings, but they highly influence click-through rate.
For example, according to the `leaked NY Times Innovation report
<http://www.scribd.com/doc/224332847/NYT-Innovation-Report-2014>`_, adding structured data
immediately increased traffic to their recipes from search engines by 52 percent.

Get Started
-----------

Markup works in a contained hierarchy setup. Adding microdata willy nilly won't guarantee proper
markup. It goes like this:

1. Itemscope: This encloses information about the item. Itemscopes can contain embedded items, such
   as a Movie having an embedded Person scope to identify the director.
2. Itemtype: Specifies the type of item immediately after the itemscope. Item types are provided as
   URLs, such as ``itemtype="http://schema.org/Movie"``.
3. Itemprop: Gives additional information about the item's properties. All items have different
   required itemprops.

Example: Movie without markup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: html

    <div>
        <h1>Avatar</h1>
        <span>Director: James Cameron (born August 16, 1954)</span>
        <span>Science fiction</span>
        <a href="../movies/avatar-theatrical-trailer.html">Trailer</a>
    </div>

Example: Movie with markup
^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: html

    <div itemscope itemtype="http://schema.org/Movie">
        <h1 itemprop="name">Avatar</h1>
        <div itemprop="director" itemscope itemtype="http://schema.org/Person">
            Director: <span itemprop="name">James Cameron</span> (born <span itemprop="birthDate">
            August 16, 1954</span>)
        </div>
        <span itemprop="genre">Science fiction</span>
        <a href="../movies/avatar-theatrical-trailer.html" itemprop="trailer">Trailer</a>
    </div>

Notice how most of the markup is added to existing page elements. This is preferred, but use
``<span>`` tags when you need to add markup around information that isn't wrapped in an element;
look at the markup around James Cameron in the example.

As a general rule, mark up only the existing content. But sometimes you will need to mark up
information that doesn't belong in the content. Use <meta> tags when you need to add hidden
information. Here's an example of this used on `rogerebert.com <rogerebert.com>`__ to add meta
information for the star rating:

.. code-block:: html

    <span itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
        <span class="star-rating"><i class="icon-star-full"></i><i class="icon-star-full"></i>
        <i class="icon-star-half"></i></span>
        <meta content="2.5" itemprop="ratingValue"></meta>
        <meta content="0.0" itemprop="worstRating"></meta>
        <meta content="4.0" itemprop="bestRating"></meta>
    </span>

Using the Markup Helper
-----------------------

Google's `Structured Data Markup Helper
<https://www.google.com/webmasters/markup-helper/?hl=en>`_  is a helpful starting place. If what
you're marking up applies, enter the URL or paste in the HTML and it will ask you to highlight and
tag the applicable fields. For an Article, you'd highlight the headline and tag it as Name, etc. If
there are any items you can't highlight on the page but still would like to complete, click "Add
missing tags" and fill them out. Once you've added all the relevant tags, click "Create HTML" and it
will highlight the pieces of code with the new microdata. Suggestions may not always be correct, so
it's highly advised to use these as a starting point.

Only a few markup types are included in Google's Markup Helper. `SEO Gadget's Guide
<http://builtvisible.com/micro-data-schema-org-guide-generating-rich-snippets/>`_ is a good resource
for finding other markup types that produce rich snippets.

Important itemtypes
-------------------

* `Article <http://schema.org/Article>`_: Necessary for In-Depth article results in Google. This is
  intended to cover articles of many different types, but you can exchange this for a more detailed
  tag.

  * `NewsArticle <http://schema.org/NewsArticle>`_: A news article. This can be used for most
    stories in place of the generic Article tag. The advantage is this more specific and can contain
    markup about the article's print edition.

  * `TechArticle <http://schema.org/TechArticle>`_: Used for "how-to (task) topics, step-by-step,
    procedural troubleshooting, specifications, etc."

* `Review <http://schema.org/Review>`_: These have rating properties that show up in search results.
  These can be a bit tricky because of the relationship between reviews and the item being reviewed.
  Look to `rogerebert.com <http://www.rogerebert.com/>`__ for examples of how to utilize this markup.

* `Event <http://schema.org/Event>`_: Will put added info in search results such as the time and
  ticket price.

* `Product <http://schema.org/Product>`_: Has many special results. Useful for review pages
  dedicated to a product. We use this for things like car reviews.

* `VideoObject <http://schema.org/VideoObject>`_: The markup for videos. Very important for standing
  out. `Google has documentation <https://support.google.com/webmasters/answer/2413309?hl=en>`_ on
  this as well.

* `Recipe <http://schema.org/Recipe>`_: Displays a wealth of information in search results.
  Necessary to compete in recipe search listings.

Reference `Schema.org <http://schema.org/>`__ for any other markup types. If you get stuck, Google
other sites correctly displaying the rich snippets and examine their source for clues.

Use Cases
---------

Some samples of Schema.org in News Applications team projects.

Article
-------

Here's the story template from the `Green Car Guide <http://cars.chicagotribune.com>`_. Notice the
breadcrumb section at the bottom further tags the articles' publisher and articleSection.

.. code-block:: html

    <article class="news-story big-news-story" itemscope itemtype="http://schema.org/Article">
        <h1 itemprop="name">{{ story.title }}</h1>
        <figure class="wide">
            <img src="{% content_item_image story 620 %}" itemprop="image">
            <figcaption>
                {% content_item_image_caption story %}
            </figcaption>
        </figure>

        <time itemprop="datePublished" content="{{story.display_time|date:"Y-m-d"}}">
            {{ story.create_time }}
        </time>

        <p id="author">
            By <span itemprop="author" itemscope itemtype="http://schema.org/Person">
                <span itemprop="name">{{ author }}</span></span>
        </p><!--author-->

        <div itemprop="articleBody">
          {{ story.body }}
        </div>

        <div class="clearfix">
            <ul class="breadcrumb">
                <li>
                    <a href="/">
                        <span itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
                            <span itemprop="name">Chicago Tribune</span>
                        </span>
                    </a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <a href="/fuel-efficient/">Fuel-Efficient Cars</a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <span itemprop="articleSection">
                        <a href="/fuel-efficient/news/">Fuel-Efficient Car News</a>
                    </span>
                </li>
            </ul>
        </div>
    </article><!--news-story-->


Product and Review
------------------

Here's a sample from the `Green Car Guide <http://cars.chicagotribune.com>`_ car template.

.. code-block:: html

    <div itemscope itemtype="http://schema.org/Product">
        <section id="detail-topper" class="row-fluid">
            <div class="span12">
                <div class="car_name">
                    <h1 class="robocop" itemprop="name">
                        2014 <span itemprop="manufacturer">Honda</span>
                        <span itemprop="model">Accord Plug-in</span>
                    </h1>
                </div><!--car_name-->
                <div class="important-specs row-fluid">
                    <div class="span3 spec">
                        <div class="spec-inner" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                            <h2 itemprop="price">$39,780</h2>
                            <span class="spec_description">Starting price</span>
                        </div><!--spec-inner-->
                    </div><!--spec-->
                </div><!--important-specs row-fluid-->

                <div class="car-detail-image">
                    <div id="carCarousel" class="carousel slide">
                        <div class="carousel-inner">
                            <div id="photo_0" class="active item">
                                <img alt="2014 Honda Accord Plug-in" itemprop="image" class="car-detail-photo" src="https://dev-chitribgreenguide.s3.amazonaws.com/images/2014_Honda_Accord_Plug_in.jpg" />
                            </div><!--photo_0-->
                        </div><!--carousel-inner-->
                    </div><!--carCarousel-->
                </div><!--car-detail-image-->
            </div><!--span12-->
        </section><!--row-fluid detail-topper-->

        <div class="row-fluid">
            <article class="span8" id="car-detail-body" itemprop="review" itemscope itemtype="http://schema.org/Review">
                <div id="chicago-index">
                    <h3>Chicago Index</h3>
                    <div id="chicago-index-number">
                        <div class="chindex-score" itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
                            <span class="chindex-bignum" itemprop="ratingValue">4</span>
                            <span class="chindex-outof"> out of <span itemprop="bestRating">5</span></span>
                        </div><!--chindex-score-->
                    </div><!--chicago-index-number-->
                </div><!--chicago-index-->
            </article><!--review-->
        </div><!--row-fluid-->
    </div><!--schema/Product-->

VideoObject
-----------

Used in Blair Kamin's `"Designed in Chicago, Made in China" series
<http://apps.chicagotribune.com/news/chicago-architecture-in-china/>`_.

.. code-block:: html

    <div class="trib-media" itemscope itemtype="http://schema.org/VideoObject">
        <aside>
            <h3 class="china-section-head video-head" itemprop="name">Shanghai&#39;s rise</h3>
            <div class="video-wrapper">
                <iframe src="//player.vimeo.com/video/86333422" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
            </div>
        </aside>
    </div>


Refining your code
------------------

Aim for tagging all relevant information while adding as little code as possible. Use Google's
`Structured Data Testing Tool <https://www.google.com/webmasters/tools/richsnippets>`_ for testing
markup. This will show you what information is being interpreted and how the search engine results
will look. Make sure all the information is being extracted properly and that the rich snippet
appears as desired.
