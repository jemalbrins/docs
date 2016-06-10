Are you done with the tarbell setup? Go over to the p2p section :ref:`blurb-p2p`

.. _blurb-tarbell:

Enabling your tarbell project to publish blurbs
===============================================

Files to be edited / created

* spreadsheet associated with project
* tarbell_config.py
* blurb html template file

Edit project-spreasheet
-----------------------

Do you know how many blurbs you'll make? Have you come up with their slugs? Are you exactly where you should be in life? Luckily, you only need to know the answer to the first two questions.

1. Make a new tab in the spreadsheet, call it "blurbs" because you're real creative.
2. Make 4 new columns, called p2p_slug, title, keywords, template. No quotes, no caps. Keep it simple.
3. Each row/entry in this tab will correspond to a blurb. Populate all the columns you created, lest you're wasteful and your code complains.
	* Note: as a convention, the name in template should start with a _ (i.e. ``_introblurbtemplate.html``)

Edit tarbell_config.py
----------------------

You're close! Jk, this is where things can go wrong the most. 

Your current tarbell_config probably only has declarations of ``SPREADSHEET_KEY``, ``EXCLUDES`` and ``S3_BUCKETS``. It's about to have more stuff, because we'll add some functions and imports. On a high-level, we are going to:

	* Loop through the blurbs' info to create and render each template
	* Upload that template to p2p
	* Add custom routes for each blurb so it can live in its own lovingly-crafted URL

Are you ready to copy and paste code? The best part! It's always good to kind of know what's going on though, so read the TL;DR above if you haven't.

Right after we declare the file's encoding and "Tarbell project configuration", import

.. code-block::

	import p2p 
	from tarbell.utils import puts
	from clint.textui import colored
	from simplejson.scanner import JSONDecodeError
	from flask import Blueprint, g, render_template
	from tarbell.hooks import register_hook`


Immediately after, we'll set the custom routes

.. code-block::

	blueprint = Blueprint('suburb-speed-tickets', __name__)
	# custom routes

	@blueprint.route('/blurbs/<p2p_slug>.html')
	def preview_blurb(p2p_slug):
		site = g.current_site
		context = site.get_context()
		
		blurb = next(b for b in context['blurbs'] if b['p2p_slug'] == p2p_slug)
		# return render_template(blurb['template'], ROOT_URL=context['ROOT_URL'], **blurb)
		return render_template(blurb['template'], blurb=blurb, **context)`


Then we'll insert a bunch of code:

.. code-block::

	def is_production_bucket(bucket_url, buckets):
	    for name, url in buckets.items():
	        if url == bucket_url and name == 'production':
	            return True
	    return False

	def render_site_template(template_name, site):
	    template = site.app.jinja_env.get_template(template_name)
	    context = site.get_context(publish=True)
	    rendered = template.render(**context)

	    if u'“' in rendered or u'”' in rendered:
	        # HACK: Work around P2P API's weird handling of curly quotes where it
	        # converts the first set to HTML entities and converts the rest to
	        # upside down quotes
	        msg = ("Removing curly quotes because it appears that the P2P API does "
	               "not handle them correctly.")
	        puts("\n" + colored.red(msg))
	        rendered = ftfy.fix_text(rendered, uncurl_quotes=True)
	    return rendered


This is the important part: notice that we're looping through ``context['blurbs']`` and pulling information from the spreadsheet. if there's a key error, it most likely happened there (make sure the wording matches)

.. code-block::

	def p2p_publish_blurb(site, s3):
	    if not is_production_bucket(s3.bucket, site.project.S3_BUCKETS):
	        puts(colored.red(
	            "\nNot publishing to production bucket. Skipping P2P publiction."))
	        return

	    context = site.get_context(publish=True)

	    p2p_conn = p2p.get_connection()

	    for blurb in context['blurbs']:
	        content = render_site_template(blurb['template'], site)

	        content_item = {
	            'slug': blurb['p2p_slug'],
	            'content_item_type_code': 'blurb',
	            'title': blurb['title'],
	            'body': content,
	            'seo_keyphrase': blurb['keywords'],
	        }
	        try:
	            created, response = p2p_conn.create_or_update_content_item(content_item)
	            if created:
	                # If we just created the item, set its state to 'working'
	                p2p_conn.update_content_item({
	                    'slug': blurb['p2p_slug'],
	                    'content_item_state_code': 'working',
	                })
	        except JSONDecodeError:
	            print('JSONDecodeError!')
	        puts("\n" + colored.green("Published to P2P with slug {}".format(blurb['p2p_slug'])))

	P2P_PUBLISH_HOOK = p2p_publish_blurb`


You can now run
.. code-block::

	tarbell publish production

and pray. 

Check p2p and look for the slug that corresponds to each template, you can preview it there.