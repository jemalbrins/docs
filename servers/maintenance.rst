Maintenance
===========

Our web servers require periodic maintenance, and this page documents common tasks our team encounters.

Server retirement
-----------------

Sometimes Amazon retires the underlying hardware that our servers are running on. Before the hardware is retired, Amazon will send us a retirement notification email, letting us know which servers are impacted.

If the impacted server does not serve live traffic (e.g. -- it's a staging server meant for internal purposes), you can simply stop and start the server from the EC2 dashboard. When you restart the server it will have migrated to new Amazon hardware. Please note that the public DNS has changed, so you will need to update any SSH aliases you have on your machine.

If the impacted server receives live traffic, then we have two options to resolve the hardware retirement issue. You can `create a new server <provisioning.html>`_ to replace the server that is to be retired, and then schedule time to swap the instances (preferably off-hours). Or, if the impacted server is an app server, you can remove the app server from the load balancer, ensure live traffic is no longer hitting the server, then stop and start the server. Then you should add the server back to the load balancer.
