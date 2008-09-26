Conversatio
===========

A simple blog system.

== Included functionality

* Multiblog system
* Multiauthors blogs
* Atom subscriptions
* Blog's archives
* Tag clouds per blog and global
* Draft & published status

Resources
=========

Plugin requirements
-------------------

In case you haven't installed any of them previously you'll need the following plugins:

* [acts\_as\_commentable](https://github.com/tog/tog/wikis/3rd-party-plugins-acts_as_commentable)
* [seo\_urls](https://github.com/tog/tog/wikis/3rd-party-plugins-seo_urls)
* [acts\_as\_taggable\_on\_steroids](https://github.com/tog/tog/wikis/3rd-party-plugins-acts_as_taggable_on_steroids)

Follow each link above for a short installation guide incase you have to install them.			

Install
-------

* Install plugin form source:

<pre>
ruby script/plugin install git://github.com/tog/tog_conversatio.git
</pre>

* Generate installation migration:

<pre>
ruby script/generate migration install_conversatio
</pre>

with the following content:

<pre>
class InstallConversatio < ActiveRecord::Migration
  def self.up
    migrate_plugin "tog_conversatio", 4
  end

  def self.down
    migrate_plugin "tog_conversatio", 0
  end
end
</pre>

* Add conversatio's routes to your application's config/routes.rb

<pre>
map.routes_from_plugin 'tog_conversatio'
</pre> 

* And finally...

<pre> 
rake db:migrate
</pre> 

More
-------

[https://github.com/tog/tog_conversatio](https://github.com/tog/tog_conversatio)

[https://github.com/tog/tog_conversatio/wikis](https://github.com/tog/tog_conversatio/wikis)


Copyright (c) 2008 Keras Software Development, released under the MIT license
