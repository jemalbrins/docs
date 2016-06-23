Accounts
--------

These are accounts for which you might need access for your work.

Amazon Web Services
~~~~~~~~~~~~~~~~~~~

Our news applications, some databases, static sites and assets are hosted on `Amazon Web Services <http://aws.amazon.com/>`_.

You can sign in to the web console for our team at https://newsapps.signin.aws.amazon.com/console.

Getting access
^^^^^^^^^^^^^^

Our team has complete control over this account, so you just need someone with administrator access to create an Identity and Access Management (IAM) user for you and to enable console login.  You'll also need to create a set of access keys to use the API to publish with Tarbell or to upload files to S3 using many popular file transfer clients.

Dropbox
~~~~~~~

The newsapps team had a shared Dropbox folder that was a great way to share and sync passwords on a Mac and also provide SSH keys.  This is still a good, useful practice for the DataViz team.

Why you might need access
^^^^^^^^^^^^^^^^^^^^^^^^^

* Access shared passwords using the Mac Keychain
* Access shared SSH keys and configuration

Getting access
~~~~~~~~~~~~~~

You'll need a personal Dropbox account.  Then, ask someone on the team with admin access to share the folder with you.

GitHub
~~~~~~

We host our public code repositories on GitHub.  You can access our "organization" page at https://github.com/newsapps/.

Why you might need access
^^^^^^^^^^^^^^^^^^^^^^^^^

* Edit these docs!
* Push fixes or updates to our public software projects

Getting access
^^^^^^^^^^^^^^

We have full control over this account.  First create a GitHub account for yourself (if you haven't already).  Then get someone with admin privileges to add you to our organization.  This account uses completely separate credentials from any of our other accounts.

Google analytics
~~~~~~~~~~~~~~~~

We use Google analytics to provide more granular tracking of off-platform projects.

Why you might need access
^^^^^^^^^^^^^^^^^^^^^^^^^

* Set up analytics for a Tarbell project that you're publishing off-platform (i.e. on apps.chicagotribune.com or graphics.chicagotribune.com).

Getting access
^^^^^^^^^^^^^^

You'll need a google account.  Ask a team member with admin access to give you access to the analytics.  You'll access with your personal Google account credentials.

Google Drive
~~~~~~~~~~~~

The News Apps team had a shared Google Drive folder called Trib Docs which is now used by the Dataviz team.

Why you might need access
^^^^^^^^^^^^^^^^^^^^^^^^^

* Automatic access to shared Tarbell spreadsheets.
* Edit and view planning documents.  

Getting access
^^^^^^^^^^^^^^

You'll need a Google account (if you use Gmail you already have one). Ask a team member with admin access to share the folder with you.  You'll access with your personal Google account credentials.


Graphics file server
~~~~~~~~~~~~~~~~~~~~

To mount the graphics network drive on a Mac:

    * Open Finder
    * Click "Go" in the top menu bar
    * Click "Connect to Server"
    * Enter ``smb://ctc-graphics.tribune.ad.trb/`` in the "Server Address" input.  
    * Click the "Connect" button
    * Authenticate using your Tribune Active Directory credentials  
    * Select "graphics" from the list of volumes if it hasn't already been selected
    * Click the "OK" button  
    * "ctc-graphics.tribune.ad.trib" should now appear in the "Shared" section in the left-hand-side pane of your Finder window 

Getting access
^^^^^^^^^^^^^^

If you don't already have access with your network ID, access can be requested by manager through http://useraccess.tribune.com/ and then IT fulfills the request


Media server
~~~~~~~~~~~~

Media server provides a way to search for staff, wire and file photos.  It is also the place to file graphics for print.  You can access the media server at http://mediaserver.usa.tribune.com/.

Why you might need access
^^^^^^^^^^^^^^^^^^^^^^^^^

* File print graphics
* Find thumbnail images for P2P  

Getting access
^^^^^^^^^^^^^^

The media server uses your Tribune AD credentials for authentication.

Manager must request access through http://useraccess.tribune.com/ and then IT fulfills the request

Shared network drives
~~~~~~~~~~~~~~~~~~~~~

There are various shared drives on the Tribune Network

* smb://ctc-edit-mac01/Mac_Folders - for sharing files between Macs and PCs

Getting access
^^^^^^^^^^^^^^

Manager must request access through http://useraccess.tribune.com/ and then IT fulfills the request

Newsgate
~~~~~~~~

Newsgate is the content management system for print publication. Many stories originate here before they hit P2P.  Some never hit P2P at all.

You use remote desktop software to access the application at https://newsgate.tribpub.com.  You'll probably need to install brower plugin and the service works with Firefox and Safari but may not work with Chrome.


Why you might need access
^^^^^^^^^^^^^^^^^^^^^^^^^

To read text of a story to develop a graphic.

Getting access
^^^^^^^^^^^^^^

This service uses your Tribune AD credentials.

Manager must request access through http://useraccess.tribune.com/ and then IT fulfills the request

.. _accounts--omniture:

Omniture
~~~~~~~~

This is an analytics service provided by Adobe.  The Tribune uses it as the main analytics tool for http://chicagotribune.com.

Why you might need access
^^^^^^^^^^^^^^^^^^^^^^^^^

To view story performance for yourself.

Getting access
^^^^^^^^^^^^^^

Email data@tribpub.com and ask them to create an account for you.

P2P
~~~

P2P is the content management system for the Tribune's website.

You can access P2P at https://p2p.tribuneinteractive.com.

Why you might need access
^^^^^^^^^^^^^^^^^^^^^^^^^

* Edit metadata for web stories
* Edit web stories
* Publish on-platform Tarbell projects  

Getting access
^^^^^^^^^^^^^^

For access, contact Destiny Gdalman at dgdalman@chicagotribune.com


Unfuddle
~~~~~~~~

Unfuddle is where we host our project tickets and code repositories.  You can access it at https://tribune.unfuddle.com/.

Note that you apparently need to be an "Account Administrator" to be able to create repositories.

Getting access
^^^^^^^^^^^^^^

We have complete control over this account, so you just need someone with administrator access to create an account for you.  This will use a separate set of login credentials from your Tribune AD credentials. 

chicagotribune.com and others
~~~~~~~~

Getting pay-walled is the worst. Follow steps below to get access to the Chicago Tribune, LA Times, and more.

Getting access
^^^^^^^^^^^^^^

As of May 2016, this site is the way to do it: http://chicagotribune.com/employeeaccess. Enter your email and validate via links!
