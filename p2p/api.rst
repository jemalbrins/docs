====================
Content Services API
====================

We can retrieve and create content in P2P using the Content Services API.

You can learn more in the `Content Services API Documentation <https://content-api.p2p.tribuneinteractive.com/docs/>`.

p2p-python
----------

To work with P2P content via the Content Services API in Python, you'll need to install the `p2p-python <https://github.com/newsapps/p2p-python>` package. 

To install this package run the following command in a terminal::

    pip install git+https://github.com/newsapps/p2p-python.git

Many of our projects will install this package automatically using a Tarbell blueprint or a requirements file, so you many not need to install this package manually.    
 
This will give you access to the `p2p` package in your Python code. With this, you can import and work with content that has been created in P2P as long as you have the slug.
