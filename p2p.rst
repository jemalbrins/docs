Using content from P2P
======================

Installing p2p-python
--------------------

To work with P2P content, you'll need to install the `p2p-python` module. In a terminal, run:

`pip install -e git://github.com/newsapps/p2p-python.git@507ef41f44f8dd53f60cc6ffb9c252fdf8d559d0#egg=p2p_tribune-dev`

This will give you access to the `p2p` module. With this, you can import and work with content
that has been created in P2P as long as you have the slug.


In Tarbell
----------

When you begin a new Tarbell project, you will need to install the `p2p-python` module. Tarbell's base template will
automatically import the module and set it up for your use.

Create your content item in P2P, and then feed the slug to your Tarbell template::

  {% set story = get_p2p_content_item("ct-chinaone-20140220") %}

This will create a variable `story` that contains the article available at the slug you chose. To display the text,
simply call the `body` attribute::

  {{ story.body }}

Now, suppose you don't want one big chunk of text, but would like to integrate pictures, pull quotes, videos, etc.
With a few filters applied to `story.body`, you can break it into individual paragraphs to place at will::

  {% set paras = story.body|replace_windows_linebreaks|paragraphs %}
  {% for p in paras[0:1] %}
      <p>{{ p|striptags|process_text }}</p>
  {% endfor %}

This block of code creates a new variable that is iterable, meaning we can use a for loop to iterate over a chosen
number of paragraphs at a time. Note that the paragraphs' numbering starts at 0, and that the for loop quits when it hits the
paragraph mentioned after the colon. So, in the example above, only the very first paragraph of the story is printed.

Here is a fuller example::

			{% for p in paras[0:1] %}
				<p class="lead drop-cap">{{ p|striptags|process_text }}</p>
			{% endfor %}

      <div class="advert" data-type-type="leaderboard"></div>

			{% for p in paras[1:7] %}
				{{ p|process_text }}
			{% endfor %}

      <div class="trib-media">
				<aside>
					<h3 class="video-head">{{ video1_headline }}</h3>
					<div class="video-wrapper">
						<iframe src="//player.vimeo.com/video/86333422" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
					</div>
				</aside>
			</div>

			{% for p in paras[7:16] %}
				{{ p|process_text }}
			{% endfor %}

TODO: Explain available filters
