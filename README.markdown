# [goodbre.ws][goodbre.ws]

Sit back and have a beer.

goodbre.ws is a Rails application powered by [Recommendable][recommendable] to provide recommendations for beer.

## Setup

### Requirements

* Ruby 1.9.x
* PostgreSQL (`brew install postgresql`)
* Redis (`brew install redis`)

### Get up and running

1. `bundle install`
2. `mv config/database.yml.example config/database.yml`
3. Edit `config/database.yml` to contain your PostgreSQL credentials
4. `mv config/initializers/secret_token.example.rb config/initializers/secret_token.rb`
5. `rake db:setup`
6. `rails s puma`

Contributing to goodbre.ws
--------------------------

Once you've made your great commits:

1. [Fork][forking] goodbre.ws
2. Create a feature branch
3. Write your code (and tests please)
4. Push to your branch's origin
5. Create a [Pull Request][pull requests] from your branch
6. That's it!

Links
-----
* Code:  `git clone git://github.com/davidcelis/goodbre.ws.git`
* Home:  <https://goodbre.ws/>
* About: <https://goodbre.ws/about>
* Bugs:  <http://github.com/davidcelis/goodbre.ws/issues>

Copyright
---------

Copyright © 2012 David Celis. See LICENSE.txt for
further details.

[goodbre.ws]: https://goodbre.ws/
[forking]: http://help.github.com/forking/
[pull requests]: http://help.github.com/pull-requests/
[recommendable]: http://davidcelis.github.com/recommendable/
[documentation]: http://rubydoc.info/gems/recommendable/frames
[gittip]: https://gittip.com/davidcelis/
[rewrite]: https://github.com/goodbrews/goodbre.ws/
