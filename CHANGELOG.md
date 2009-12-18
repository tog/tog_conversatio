Edge
----

0.6.0
----

* Destroy posts when deleting blog (kudos to Andrei Erdoss)
* I18n for bloggerships management (kudos to Andrei Erdoss)
* index method in conversatio/posts_controller with redirect to blog to avoid calls to post's index
* removed deprecation warnings caused by using formatted_conversatio_blog_url
* Migrated from acts_as_state_machine to AASM gem


0.5.4
----
* Use "comment_user_name(comment)" instead of "comment.user.login"

0.5.3
----

0.5.2
----

0.5.1
----

* Support for Rails 2.3.2 (kudos to Andrei Erdoss)
* Renamed AASM transtitions to verbs (kudos to Balint Erdi)
* (almost) Full i18n (kudos to Andrei Erdoss)
* Renamed routes.rb to desert_routes.rb (Rails 2.3 + desert 0.5 support)
* New installation template
* Fixed bug in archive listing
* Cascade delete for post when a blog is destroyed
* Fixed bug with post's state handling


0.5.0
----
* Fix published\_posts

0.4.4
----

0.4.3
----

0.4.2
----
* Ticket #84. Can't add more bloggers to a blog
* Ticket #114. Order post index in member section by created_at
* Ticket #115. Create a 'published_at' column on public post index

0.4.0
----
* Added some tests
* Remove model namespaces
* Added sphinx search using thinking\_sphinx
* Sanitize tags change allowed
* Ticket #102. Consolidate comments listing and form
* acts\_as\_taggable\_on\_steroids dependency is already in tog\_core
* Manage spam comments

0.3.0
----
* Translated 'Tags' to english
* Just removed empty line
* Checking published post size before getting last posts
* Loads helper from init.rb
* Changed installation URL, use public instead of private url
* Ticket #83. Cant's show all blogs' tag cloud

