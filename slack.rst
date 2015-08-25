Slack
=====

We use `Slack <https://slack.com>`_ for our internal messaging.

Pinging a channel on repo changes
---------------------------------

You can configure an `Incoming Webhook <https://api.slack.com/incoming-webhooks>`_ integration to send a message to a channel when a commit is pushed to a git repository hosted in Unfuddle. 

Geoff wrote a `simple Flask app <https://github.com/newsapps/flask-slackunfuddle>`_ to proxy the webhook request sent by Unfuddle to the Slack endpoint that receives it.

The instance of this app runs at http://slackunfuddle.tribapps.com and its repo is at https://tribune.unfuddle.com/a#/projects/6/repositories/337/browse.

Configuration
^^^^^^^^^^^^^

Add a new ``Incoming Webhook`` integration by visiting https://tribdata.slack.com/services/new/incoming-webhook.  Select the channel that you want the commit messages sent to and click the "Add incoming webhooks integrtion" button.

After you add the integration, it will give you a webhook URL that will look something like this::

    https://hooks.slack.com/services/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

Go to the repository settings in Unfuddle and in the ``Callback URL`` text input, type in a URL that begins with ``http://slackunfuddle.tribapps.com/`` and ends with the part of the Slac webhook URL that begins with ``services``.  So, for the example webhook URL above, the callback URL for unfuddle would be::

    http://slackunfuddle.tribapps.com/services/T0474V5VA/B09448H0T/vOPTW9mtZyBfFQ5gmsfQVBh1

Click the ``Test the callback URL`` button and you should get a message like::

    Callback Url Test Result: 200 OK: Callback performed successfully.  

Click the ``Save Changes`` button.    
