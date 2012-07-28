-- SHAREBOX --

How to Build a Dropbox-like Sharing App using Ruby on Rails
By: Phyo Wai

Tutorial found on:http://http://codyaray.com/downloads/2012/03/How-to-Build-a-Dropbox-like-Sharing-App-using-Ruby-on-Rails.html 

The tutorial assumes the following applications are installed
Ruby 1.9.+
Rails 3+
MySQL 5+

MySQL 5+ not installed on current machine, installed it through:
  sudo apt-get install mysql-server
Entered the following login information:
  username: root
  password: admin

Notes during tutorial:

STEP 1:

Instructions to add "gem 'ruby-mysql'" to Gemfile, however couldn't get database to work with this gem. Error message when executing rake db:create:
  Please install the mysql adapter: `gem install activerecord-mysql-adapter` 
Problem should be solved by running:
gem install activerecord-mysql-adapter
However getting error message :
ERROR:  Could not find a valid gem 'activerecord-mysql-adapter' (>= 0) in any repository

Decided to use mysql2 as a replacement Sql server (this one is listed as default in the Gemfile)

Needed to run the following commmands to get mysql2 installed:
1. sudo apt-get install libmysql-ruby libmysqlclient-dev
2. gem install mysql2

Modifying database.yml:
Socket location for mysql was incorrect. Used the following command to find the right location:
  mysqladmin variables | grep socket
This gave the following output: /var/run/mysqld/mysqld.sock
Replaced socket: /tmp/mysql.sock with:
  socket:  /var/run/mysqld/mysqld.sock

Also changed the following lines:
  adapter: mysql2
  password: admin

