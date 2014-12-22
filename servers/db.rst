==
db
==

Changelog
=========

2014-12-22: Installed tmux
--------------------------

In order to run one-off, long-running processes, and because I'm less familiar with the already-installed ``screen``,  installed tmux::

        newsapps@db:~$ sudo apt-get install tmux
        Reading package lists... Done
        Building dependency tree
        Reading state information... Done
        The following packages were automatically installed and are no longer required:
          libx86-1 libpciaccess0 vbetool libffi5 libhal1 hal libhal-storage1 python-dbus pm-utils smartdimmer radeontool hal-info python-smartpm python-gobject
          Use 'apt-get autoremove' to remove them.
          The following NEW packages will be installed:
            tmux
            0 upgraded, 1 newly installed, 0 to remove and 38 not upgraded.
            Need to get 176kB of archives.
            After this operation, 426kB of additional disk space will be used.
            Get:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ lucid/universe tmux 1.1-1 [176kB]
            Fetched 176kB in 0s (299kB/s)
            Selecting previously deselected package tmux.
            (Reading database ... 44044 files and directories currently installed.)
            Unpacking tmux (from .../archives/tmux_1.1-1_i386.deb) ...
            Processing triggers for man-db ...
            Processing triggers for ureadahead ...
            Setting up tmux (1.1-1) ...
