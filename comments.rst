Facebook Comments
=================

How Tribune Facebook commenting works
-------------------------------------

The Chicago Tribune primarily uses Facebook commenting, which means all that you need to
include comments is a bit of code on the html page(s).

Example using Tarbell
---------------------

If you're using the `Tribune Tarbell template <tarbell.html#templates>`_, all you need to do is
ensure that there's an element (preferably a ``<div>``) on the page with the id
``"fb-comments"``:

.. code-block:: html

    <div id="fb-comments"></div>

Tarbell will take care of the rest. If you've made
changes to the base template, you'll need to preserve the ``{% block comments %}`` and 
``{% block comments_js %}`` sections and the ``fb:app_id`` meta tag in the
``{% block comments_app_id %}`` section.

If you'd like to change the disclaimer text, copy ``_base/_comments.html`` to your root directory 
and update it as described in the next section.

Changing disclaimer text
------------------------

The disclaimer text is what appears above the Facebook comments box, briefly explaining what it is
and our policies. In order to customize it, you need to find a block of Javascript code like the 
following:

.. code-block:: javascript

    window.add_facebook_comments = function() {
        var disclaimer = '<div class="fb-comment-disclaimer">The Tribune is using Facebook comments 
            on stories. To post a comment, log into Facebook and then add your comment. To report 
            spam or abuse, click the "X" in the upper right corner of the comment box. In certain 
            circumstances, we will take down entire comment boards. Our commenting guidelines can 
            be found
            <a href="http://www.chicagotribune.com/about/chi-discussions-faq,0,980840;htmlstory">
            here »</a>.</div>';

        var fbml = disclaimer + '<fb:comments href="'
            + window.location.protocol
            + '//'
            + window.location.host
            + window.location.pathname
            + '" num_posts="10" width="620"></fb:comments>';

        $("#fb-comments").append(fbml);
    }

All you need to change is the text on the line beginning ``var disclaimer``. Replace everything
between ``<div class="fb-comment-disclaimer">`` and ``</div>`` with whatever new disclaimer you
like.

Moderating comments
-------------------

Comments can be moderated by an administrator of the Facebook app you choose. Tarbell projects use 
the app id ``306836229411287`` but you're free to set up and use a different one.

Comment moderation using this system is handled entirely through Facebook, in particular their
`Comment Moderation Tool <https://developers.facebook.com/tools/comments>`_. If you've already been 
added as a moderator for the app, then visiting that page will show you all recent comments and 
allow you to take action. Visiting the page containing the comment box will also allow you to 
moderate them, once you've logged into Facebook.

In order to add yourself as a moderator, you or an administrator of the app you're using should
visit the `Comment Moderation Tool <https://developers.facebook.com/tools/comments>`_, select the
app you're using and click on Settings. You'll need to have a Facebook account in order to become
an administrator or moderator.

Where to go for Facebook questions
----------------------------------

Since Facebook is the developer and maintainer of the commenting code, they're the best place to 
look for any questions you have about creating and administering apps. `Facebook's App Dashboard 
<https://developers.facebook.com/apps>`_ is the clearinghouse for everything app-related, and `their
commenting documentation is here <https://developers.facebook.com/docs/plugins/comments>`_.

For non-Tarbell sites
----------------------------------

If you'd like to include Facebook Comments on a non-Tarbell site, you'll need to include a bit
more boilerplate code. Here's everything you'll need to include on any page that contains a
comments box.

In your page's ``<head>``, you need to add a meta tag that tells Facebook what app to use for your
comments:

.. code-block:: html

    <meta property="fb:app_id" content="INSERT_APP_ID_HERE">


Create a ``<div>`` element somewhere on the page that you'd like the comments box to appear, and
give it the id ``fb-comments``:
    
.. code-block:: html

  <div id="fb-comments"></div>

Finally, at the bottom of your page code, add the following:

.. code-block:: html

    <div id="fb-root"></div>    

    <script type="text/javascript">
        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=APP_ID_GOES_HERE";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>

    <script type="text/javascript">
       window.add_facebook_comments = function() {
         var disclaimer = '<div class="fb-comment-disclaimer">The Tribune is using Facebook 
            comments on stories. To post a comment, log into Facebook and then add your comment. To 
            report spam or abuse, click the "X" in the upper right corner of the comment box. In 
            certain circumstances, we will take down entire comment boards. Our commenting 
            guidelines can be found
            <a href="http://www.chicagotribune.com/about/chi-discussions-faq,0,980840.htmlstory">
            here »</a>.</div>';

         var fbml = disclaimer + '<fb:comments href="'
             + window.location.protocol
             + '//'
             + window.location.host
             + window.location.pathname
             + '" num_posts="10" width="620"></fb:comments>';

          $("#fb-comments").append(fbml);
       }

       if ( $('meta[property="fb:app_id"]').length > 0 ) {
          window.add_facebook_comments();
       }
    </script>

In the line that begins ``js.src = "//connect.facebook.net...``, replace ``APP_ID_GOES_HERE`` with
the app id you're using for these comments.

You can change the disclaimer text by updating the line that begins ``var disclaimer = '<div...``
(see `the above section <#changing-disclaimer-text>`_ for more details).

Note that you can attach the comments to a differently-named element on the page by changing the
line that contains ``$("#fb-comments").append(fbml);``, but you shouldn't need to in most cases.
