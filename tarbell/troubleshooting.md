# Tarbell tears: troubleshooting common problems

When running `$ tarbell newproject`, sometimes things happen that make us really sad because they don’t work. Here are some common problems, in no particular order:

```eval_rst
.. note::

  Add your own issue to this page. Read how `How to contribute`_!
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

## When it broke: "Tarbell spreadsheet" command not working

### Traceback

```sh
Error: Error! Unknown command 'spreadsheet'.
```

### Solution

The answer is probably that you've installed a project that switched to an old version of tarbell. Check your version of tarbell by running `tarbell -v`. "Tarbell spreadsheet" is available in v1.0.4 and 1.0.5. Run `pip install --upgrade tarbell` to upgrade to the latest version of Tarbell.

_submitted by Chad_

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

Change the filter to be a [context filter](http://flask.pocoo.org/docs/0.11/api/#flask.Blueprint.app_context_processor), which gets the template context passed as an argument by Jinja instead of having to grab it explicitly  with `context = g.current_site.get_context()`

_submitted by Chad_

----------

## When it broke: Tried to publish to P2P and styles don't come through in P2P preview

### Solution

So far, I've encountered two solutions to this:
- In _content.html, if you have
  
  ```
  <div class="graphic-wrapper">
    {% include "_text.html" %}
  </div>
  ```
  make it

  ```
  <div class="graphic-wrapper">
    {% include "_text.html" with context %}
  </div>
  ```
  The "with context" forces P2P to apply the same attributes from the parent element to the child element.

- Make sure that all commented out lines in _content.html are removed before publishing to prod. Commented out lines mess with the way P2P runs scripts.

_submitted by Nausheen_


----------

## When it broke: Tried to run npm install and it errored out

### Traceback

```sh
tt-edt-ct07505:mlb-record-playoffs jberlin$ npm install
npm ERR! fetch failed https://tribune.unfuddle.com/git/tribune_trib-styles/
npm WARN retry will retry, error on last attempt: Error: fetch failed with status code 401
npm ERR! fetch failed https://tribune.unfuddle.com/git/tribune_trib-styles/
npm WARN retry will retry, error on last attempt: Error: fetch failed with status code 401
npm ERR! fetch failed https://tribune.unfuddle.com/git/tribune_trib-styles/
npm ERR! Darwin 14.5.0
npm ERR! argv "/usr/local/Cellar/node/5.4.1_1/bin/node" "/usr/local/bin/npm" "install"
npm ERR! node v5.4.1
npm ERR! npm  v3.10.8

npm ERR! fetch failed with status code 401
npm ERR! 
npm ERR! If you need help, you may report this error at:
npm ERR!     <https://github.com/npm/npm/issues>

npm ERR! Please include the following file with any support request:
npm ERR!     /Users/jberlin/code/mlb-record-playoffs/npm-debug.log
```

### Solution

The new Tribune styles had a bad URL for a git repo. It was listed without the correct prefix in the "dependencies" area of the package.json file.

Geoff helped find the right format for URLs like this and we had to add **git+** to the front of it. The Trib styles were likely not installed correctly on the project. I made the changes and pushed the new version of **package.json** to the project.

_submitted by Jonathon_

----------

#### How to contribute
* The docs [repo](https://github.com/newsapps/docs) can be edited in github (browser) if you'll just add one problem/fix (recommended if you won't add to multiple files)
* For multi-file adds, clone the [repo](https://github.com/newsapps/docs), commit and push your changes
* Write markdown if you're more comfortable with that. [Here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) is a handy cheat-sheet.
* Let `#techtalk` channel on slack know you've updated the docs!
