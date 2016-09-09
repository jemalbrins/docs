# Tarbell tears: troubleshooting common problems

When running `$ tarbell newproject`, sometimes things happen that make us really sad because they don’t work. Here are some common problems, in no particular order:

```eval_rst
.. note::

  `Add your own issue to this page in the <How to contribute>`_ section!
```

## When it broke: tried to run `npm run build && npm run watch`

### Traceback

```sh
npm ERR! Darwin 15.5.0
npm ERR! argv "/usr/local/Cellar/node/5.6.0/bin/node" "/usr/local/bin/npm" "run" "build"
npm ERR! node v5.6.0
npm ERR! npm  v3.6.0
npm ERR! code ELIFECYCLE
npm ERR! Gliniewicz@0.0.1 build: `grunt`
npm ERR! Exit status 99
npm ERR!
npm ERR! Failed at the Gliniewicz@0.0.1 build script 'grunt'.
npm ERR! Make sure you have the latest version of node.js and npm installed.
npm ERR! If you do, this is most likely a problem with the Gliniewicz package,
npm ERR! not with npm itself.
npm ERR! Tell the author that this fails on your system:
npm ERR!     grunt
npm ERR! You can get information on how to open an issue for this project with:
npm ERR!     npm bugs Gliniewicz
npm ERR! Or if that isn't available, you can get their info via:
npm ERR!     npm owner ls Gliniewicz
npm ERR! There is likely additional logging output above.
npm WARN Local package.json exists, but node_modules missing, did you mean to install?
```
### Solution

Run `npm install` before `npm run build && npm run watch`

_submitted by Cecilia_

----------

## When it broke: running `tarbell publish` on a cloned project

### Error 

```sh
jinja2.exceptions.TemplateNotFound: _base.html
``````

### Solution 

- Way 1: If it’s a Tarbell project, you could just run `tarbell install {project-git-url}`
    * How to check if it’s a Tarbell project? Is there a tarbell_config.py file in your repo? Then yes.
- Way 2: For any git repo that uses submodules: run `git submodule init && git submodule update`

_submitted by Cecilia_

----------

## When it broke: Tried to publish to p2p blurb, tarbell publish production

### Traceback

```sh
Traceback (most recent call last):
  File "/usr/local/bin/tarbell", line 11, in <module>
    sys.exit(main())
  File "/usr/local/lib/python2.7/site-packages/tarbell/cli.py", line 74, in main
    command.__call__(command, args)
  File "/usr/local/lib/python2.7/site-packages/tarbell/cli.py", line 931, in __call__
    return self.fn(*args, **kw_args)
  File "/usr/local/lib/python2.7/site-packages/tarbell/cli.py", line 390, in tarbell_publish
    site.call_hook("publish", site, s3)
  File "/usr/local/lib/python2.7/site-packages/tarbell/app.py", line 359, in call_hook
    function.__call__(*args, **kwargs)
  File "/Users/cyoder/tarbell/cutler-tracker/_blueprint/blueprint.py", line 159, in p2p_publish
    p2p_publish_hook(site, s3)
  File "/Users/cyoder/tarbell/cutler-tracker/tarbell_config.py", line 68, in p2p_publish_blurb
    content = render_site_template(blurb['template'], site, **extra_context)
  File "/Users/cyoder/tarbell/cutler-tracker/tarbell_config.py", line 39, in render_site_template
    rendered = template.render(**context)
  File "/usr/local/lib/python2.7/site-packages/jinja2/environment.py", line 969, in render
    return self.environment.handle_exception(exc_info, True)
  File "/usr/local/lib/python2.7/site-packages/jinja2/environment.py", line 742, in handle_exception
    reraise(exc_type, exc_value, tb)
  File "/Users/cyoder/tarbell/cutler-tracker/_content.html", line 2, in top-level template code
    {% block container %}
  File "/Users/cyoder/tarbell/cutler-tracker/_content.html", line 3, in block "container"
    {% block content %}
  File "/Users/cyoder/tarbell/cutler-tracker/_content.html", line 8, in block "content"
    {% for game in games|sort(attribute='num') if game|game_stats %}
  File "/Users/cyoder/tarbell/cutler-tracker/tarbell_config.py", line 102, in game_stats
    context = g.current_site.get_context()
  File "/usr/local/lib/python2.7/site-packages/werkzeug/local.py", line 343, in __getattr__
    return getattr(self._get_current_object(), name)
  File "/usr/local/lib/python2.7/site-packages/werkzeug/local.py", line 302, in _get_current_object
    return self.__local()
  File "/usr/local/lib/python2.7/site-packages/flask/globals.py", line 27, in _lookup_app_object
    raise RuntimeError('working outside of application context')
RuntimeError: working outside of application context
```

### Solution

Cchange the filter to be a [context filter](http://flask.pocoo.org/docs/0.11/api/#flask.Blueprint.app_context_processor), which gets the template context passed as an argument by Jinja instead of having to grab it explicitly  with `context = g.current_site.get_context()`

_submitted by Chad_

----------

#### How to contribute
* The docs [repo](github.com/newsapps/docs) can be edited in github if you'll just add one problem/fix (recommended if you won't add to multiple files)
* For multi-file adds, clone the [repo](github.com/newsapps/docs), commit and push your changes
* Write markdown if you're more comfortable with that. [Here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is a handy cheat-sheet.
* Let `#techtalk` channel on slack know you've updated the docs!
