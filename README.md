Heroku Deploy
=============

Make it a little easier to deploy to Heroku.

Installation
------------

    $ heroku plugins install git://github.com/mojotech/heroku-deploy.git

Usage
-----

    $ heroku deploy    # git push -f <remote> master
    $ heroku deploy -m # <push>; <maintenance on>; <migrate>; <maintenance off>
