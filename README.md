Heroku Deploy
=============

Make it a little easier to deploy to Heroku.

Installation
------------

    $ heroku plugins install git://github.com/mojotech/heroku-deploy.git

Usage
-----

To deploy:

    $ heroku deploy     # git push -f <remote> master
    $ heroku deploy -v  # git push --verbose -f <remote> master
    $ heroku deploy -m  # <push>; <maintenance on>; <migrate>; <maintenance off>
    $ heroku deploy -mb # <push>; <maintenance on>; <backup>; <migrate>; <maintenance off>

To migrate:

    $ heroku deploy:migrate    # <maintenance on>; <migrate>; <maintenance off>
    $ heroku deploy:migrate -b #  <maintenance on>; <backup>; <migrate>; <maintenance off>

To backup:

    $ heroku deploy:backup # pgbackups:capture --expire SHARED_DATABASE

Bugs
----

* Backup should allow choosing something other than `SHARED_DATABASE`.
