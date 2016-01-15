============
System Setup
============

This guide was written when some of our team got new PowerBook notebooks in January 2016.

This is based on `notes taken by Chad Yoder <https://docs.google.com/document/d/1tHvgD4KdFF8nVdgTLq-pk0Ty15KylxadcOCqI0pKmTQ/edit>`_ as he set up his system.

Other Guides
------------

* `Bootstrapping a new rig <https://docs.google.com/document/d/1Bfi-YabhWJEmWPDQqWh_26cBqaP-ogJNJ67bPJlAC9o/edit>`_ (our old guide, last edited June 22, 2013 by Andy Boyle)
* `Brian Boyer's Lion dev environment notes <https://gist.github.com/brianboyer/1696819>`_  

Glossary
--------

TODO: define these terms

* commit
* shell
* package
* library
* repository  
* command line  
* terminal  
* home directory  

Install Xcode
-------------

Xcode is a set of developer tools from Apple.  Most importantly, it includes a `compiler <https://en.wikipedia.org/wiki/Compiler>`_ that transforms source code (usually in C or C++) into an executable program.  The compiler is needed to build packages with Homebrew.

You can install it from the `App Store <https://itunes.apple.com/us/app/xcode/id497799835?mt=12>`_.

Do this step first, because it can take a long time to install.  While you're waiting, you can move on to a few of the following steps.



Get a better terminal program
-----------------------------

Install `iTerm 2 <https://www.iterm2.com/>`_.  It has `many useful features <https://www.iterm2.com/features.html>`_ that the built in Terminal doesn't.

Create a directory for your non-Tarbell coding projects
-------------------------------------------------------

.. code:: bash

    mkdir ~/code
    
Create a directory for your user scripts
----------------------------------------

.. code:: bash

    mkdir ~/bin    
    
Install a better text editor
----------------------------

Lots of people in this group use `Sublime Text <https://www.sublimetext.com/>`_.  `Atom <https://atom.io/>`_ is another good one.

Configure the Sublime Text command line
---------------------------------------

Follow `these instructions <https://www.sublimetext.com/docs/2/osx_command_line.html>`_.


Create an SSH keypair
---------------------

Make sure one doesn't exist already:

.. code:: bash

    [ -f ~/.ssh/id_rsa ] || printf "No ssh key exists, you need to create one\n"

If this outputs a message saying you need to create a new SSH key, generate an SSH keypair:

.. code:: bash

    ssh keygen


Add the key to Unfuddle
-----------------------

Open https://tribune.unfuddle.com/a#/people/settings in your browser.  If this URL doesn't work, look for the "Personal Settings" section of the site. 

Then copy your newly-created public key to the clipboard:

.. code:: bash

    cat ~/.ssh/id_rsa.pub | pbcopy

Click "New Public Key", give your key a name like "Tribune MacBook" and paste the key that you copied to the clipboard into the "Value" text area.

Click the "Add Key" button to save the key.

Create a .bashrc file
--------------------

The `.bashrc` file sets up the environment for your shell.  This could be things like the default text editor, or configuration variables for certain command-line programs. 

.. code:: bash

    touch ~/.bashrc
    open ~/.bashrc

Add these lines to your `~/.basrhrc`:

.. code:: bash

   export PATH=$HOME/bin:$PATH
   export EDITOR='subl -w'

Make sure your .bashrc is loaded by login shells
------------------------------------------------

.. code:: bash

  touch ~/.profile
  subl ~/.profile

Add this line to the end of the file:

.. code:: bash

    source ~/.bashrc

Agree to the Xcode license
--------------------------

Once Xcode is installed, you'll need to agree to the license before you can use the tools, or install packages with Homebrew.

.. code:: bash

    sudo xcodebuild -license

    
Install Homebrew
----------------

This will be used to install a number of other useful software packages.

Follow the installation instructions on the `Homebrew website <http://brew.sh/>`_.

While many developent tools like Python and git come pre-installed on the Mac system, or are installed with Xcode, we'll use Homebrew to install more recent versions of these tools.  Installing them with Homebrew also makes it easier to install multiple versions of the software and to see which version is installed.



Install some packages with Homebrew
-----------------------------------

.. code:: bash

        brew install git python node

`Git <https://git-scm.com/>`_ is a source code management (SCM) system that we use to version control our coding projects.  It makes it easy to experiment without losing work you've already done and for others to collaborate with you.  It's the software behind the popular `GitHub <https://github.com>`_ service.

`Python <https://www.python.org/>`_ is a multi-use programming language that we use for many of our projects.  It works well in the newsroom because it is good for developing web applications and working with data.

`Node.js <https://nodejs.org/en/>`_ is an environment for running JavaScript programs on your computer or on a server instead of in the browser.  Many of the tools that we use to build the CSS and JavaScript in projects are written in JavaScript and use Node.js. JavaScript, usign Node.js is also a reasonable choice for writing system management or data scraping or processing scripts.

Install Sass
------------

`Sass <http://sass-lang.com/>`_ is a language that makes it easier to write more modular, reusable CSS styles.  In many of our projects, we write the styles in Sass, which is pretty similar to CSS, and compile it into CSS.

.. code:: bash

        sudo gem install sass

Configure git
-------------

Set your name and email.  These will show up in git commit messages so that others know who made certain changes to the code and how to contact them.

.. code:: bash

    git config --global user.name "YourFirstName YourLastName" # Replace with your first and last name
    git config --global user.email youremail@domain.com  # Replace with your email address

Set Sublime Text as your default editor for commit messages. If you want to use an editor other than Sublime Text, `these instructions <https://help.github.com/articles/associating-text-editors-with-git/>`_ might be helpful.

.. code:: bash

    git config --global core.editor "subl -n -w"


Clone the secrets repository 
----------------------------

It's a bad practice to keep usernames and passwords for various services in your source code.  We keep them in a separate repository, and then load them as environment variables.  Clone this repository:

.. code:: bash

    cd ~/code
    git clone git@tribune.unfuddle.com:tribune/secrets.git


Make sure your path is set to use the Homebrew-installed version of Python
--------------------------------------------------------------------------

.. code:: bash

        which python

This should report back `/usr/local/bin/python`.

Install virtualenvwrapper
-------------------------

`virtualenvwrapper <https://virtualenvwrapper.readthedocs.org/>`_ is a tool that we use to isolate Python environments.  Different projects may require different versions of dependencies.  If we just installed them globally, installing one project's dependency could break another project. Install it like this:


.. code:: bash

    pip install virtualenvwrapper

Install Tarbell
---------------

.. code:: bash

    pip install tarbell

Install grunt and gulp globally 
-------------------------------

`Grunt <http://gruntjs.com/>`_ and `Gulp <http://gulpjs.com/>`_ are JavaScript task runners that we use to automate building JavaScript and CSS in our Tarbell projects.  You'll need to install these globally so you can run the commands in any project.

.. code:: bash

    npm install -g grunt-cli gulp

Configure Tarbell
-----------------

Before you start, you'll need a few accounts for services we use:

* Google
* Amazon AWS, in particular access keys

Once you have the credentials for these accounts in hand, run: 

As part of the configuration process, you'll be asked to create an Oauth client Id for Google's APIs.  Setting up the client ID can be tricky.  Ask someone for help if you get stuck.

When you download the API credentials from Google, save the file with the filename `~/Downloads/client_secrets.json` or rename the downloaded file to `~/Downloads/client_secrets.json`.   

Setting up the Oauth client ID can be tricky.  Ask someone for help if you get confused.

During the configuration process, you'll be asked for the default staging bucket.  This is `apps.beta.tribapps.com`.  You'll also be asked for the default production bucket.  This is `apps.chicagotribune.com`.

Once you're ready to start the configuration process, run:

.. code:: bash

    tarbell configure

Add your home directory and tarbell folder to your finder sidebar
-----------------------------------------------------------------

* Open Finder.
* Click the `Go` menu at the top of the screen, then choose `Home`.
* Click  the `File` menu, then `Add to sidebar`.
* Double click on the `tarbell` folder.
* Click  the `File` menu, then `Add to sidebar`.

Test your Tarbell installation
------------------------------

Install the tester Tarbell project:

.. code:: bash

    tarbell install git@tribune.unfuddle.com:tribune/tester.git
    cd ~/tarbell/tester
    tarbell serve

Open http://127.0.0.1:5000 in your browser.  You should see a welcome page.

Now lets make sure you can install front-end build tools:

.. code:: bash

    npm install
    grunt

These commands should run and terminate without error.    

Configure Tarbell to include our custom blueprints
--------------------------------------------------

.. code:: bash

    subl ~/.tarbell/settings.yaml

Make sure these values are under the `project_templates` key:

.. code:: yaml

    - name: Tribune template          
      url: git@tribune.unfuddle.com:tribune/tarbell-base.git
    - name: Tribune template (P2P)
      url: git@tribune.unfuddle.com:tribune/tarbell-blueprint-p2p.git  


