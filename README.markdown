Conversatio
===========

A simple blog system.


Resources
=========

Plugin requirements
-------------------

In case you haven't installed any of them previously you'll need the following plugins:

h3. acts_as_commentable

This is a requirement for tog, so you should have already installed it!.

h3. seo_urls

<pre>      
script/plugin install http://svn.redshiftmedia.com/svn/plugins/seo_urls
</pre>

more: "http://www.bitbutter.com/seo_urls-plugin-making-show-pages-more-findable/14":http://www.bitbutter.com/seo_urls-plugin-making-show-pages-more-findable/14

h3. acts_as_taggable_on_steroids

For those of you impatient:
		
# install plugin:   
     
<pre>
script/plugin install http://svn.viney.net.nz/things/rails/plugins/acts_as_taggable_on_steroids
</pre>		
				
# generate migration:   
 
<pre>				
script/generate acts_as_taggable_migration
</pre>			

more: "http://svn.viney.net.nz/things/rails/plugins/acts_as_taggable_on_steroids/README":http://svn.viney.net.nz/things/rails/plugins/acts_as_taggable_on_steroids/README
			

Install
-------

* Install plugin form source:

<pre>
ruby script/plugin install git@github.com:tog/tog_conversatio.git
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

"https://github.com/tog/tog_conversatio":https://github.com/tog/tog_conversatio

"https://github.com/tog/tog_conversatio/wikis":https://github.com/tog/tog_conversatio/wikis


Copyright (c) 2008 Keras Software Development, released under the MIT license