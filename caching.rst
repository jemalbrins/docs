Caching
=======

Our applications may cache responses in a number of ways including Varnish, Nginx and Django.

Varnish
-------

`Varnish <https://www.varnish-cache.org>`_ is a caching HTTP reverse proxy.

Clearing the cache
~~~~~~~~~~~~~~~~~~

Applications that use Varnish for caching should be able to run the ``clear_url`` or ``clear_cache`` Fabric tasks defined in our `deployment tools <https://github.com/newsapps/deploy-tools>`_.

Examples of applications that use this cache
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* `Chicago Now <http://chicagonow.com/>`_


Nginx
-----

Many of our applications are served using the Nginx webserver.  Nginx `supports caching of responses <http://nginx.com/resources/admin-guide/caching/>`_.

An app that uses Nginx caching has a configuration that looks like this::


        proxy_cache_path /mnt/nginx-cache/homicides levels=1:2 keys_zone=homicides:1000m;

        server {
            ...

            location / {
                ...

                # caching
                proxy_cache homicides;
                proxy_cache_use_stale updating;
                proxy_cache_valid 15m;
                proxy_cache_key $request_uri;
                add_header X-Cached $upstream_cache_status;
                proxy_read_timeout 30s;

                proxy_pass http://unix:/tmp/homicides.sock;
            }
        }

Clearing the cache
~~~~~~~~~~~~~~~~~~

To clear the Nginx cache, simply delete the files in the cache directory specified with the ``proxy_cache_path`` directive.

Assuming the configuration above, you would clear the cache like this::

    find /mnt/nginx-cache/homicides -type f -delete

Examples of applications that use this cache
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* `Homicides <http://homicides.redeyechicago.com/>`_

Django
------

Django has a `cache framework <https://docs.djangoproject.com/en/1.7/topics/cache/>`_ that supports a wide range of caching uses, from low-level values to responses.  Some of our apps use `per-site caching <https://docs.djangoproject.com/en/1.7/topics/cache/#the-per-site-cache>`_ which is implemented through middleware classes.

Applications that use Django's per-site cache have Django settings modules with configuration like this::

        ...


        # Caching
        CACHE_MIDDLEWARE_KEY_PREFIX = 'missedconnections'
        CACHE_MIDDLEWARE_SECONDS = 90 * 60  # 90 minutes
        CACHE_BACKEND = "dummy:///"

        ...

        MIDDLEWARE_CLASSES = (
            ...
            'django.middleware.cache.UpdateCacheMiddleware',
            'django.middleware.cache.FetchFromCacheMiddleware',
            ...
        }

        CACHES = {
            'default': {
                'BACKEND': 'redis_cache.cache.RedisCache',
                'LOCATION': 'redis.aws.tribapps.com:6379:1',
                'TIMEOUT': 21600
            }
        }

Note that other applications may use Django's lower-level cache API to implement other caching strategies within the application. 

Clearing the cache
~~~~~~~~~~~~~~~~~~

There's not a built-in, high-level way to clear a subset of items in the Django per-site cache.  If you search, you'll find a number of Django application packages or snippets that can make this easier.

Examples of applications that use this cache
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* `Missed Connections <http://missedconnections.redeyechicago.com/>`_
