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

PART 2:

After installing devise the following information is given for changes that need to be added manually:

===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here 
     is an example of default_url_options appropriate for a development environment 
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { :host => 'localhost:3000' }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root :to => "home#index"

CAN BE SKIPPED! This is done by nifty generator in our case
  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

IS SKIPPED FOR NOW
  4. If you are deploying Rails 3.1 on Heroku, you may want to set:

       config.assets.initialize_on_precompile = false

     On config/application.rb forcing your application to not access the DB
     or load models when precompiling your assets.

===============================================================================
The command for the following step is missing:
	Now, let's create our first model, User, using "devise".
Use this command:
	rails generate devise User

# Info found on https://github.com/plataformatec/devise#getting-started
# General command: rails generate devise MODEL

Instead of running the modified ..._devise_create_user.rb file as specified by the tutorial decided to run the migration file created by devise. Only added the following line just before t.timestamps:
	t.string :name

  Added the following lines in "app/views/devise/registrations/new.html.erb" (slightly different from the tutorial lines)
    <div><%= f.label :name %><br />  
  <%= f.text_field :name %></div>

  users/sign_out/ didn't work replaced the following line in config/routes.rb
    devise_for :users
  replaced with:
    devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' end

  STEP 3 Add Basic CSS
  
  Added CSS information not in "public/stylesheets/application.css" but in newly created file:
   app/assets/stylesheets/custom.css

  STEP 4 Uploading files

  After adding gem "paperclip", "~> 2.3" in gemfile had to run bundle install twice. After the first bundle install the following line was generated during output:
     gemfile  mocha

First tried to run rake db:migrate but got the following error:
  Could not find gem 'mocha (>= 0) ruby' in the gems available on this machine.
  Run `bundle install` to install missing gems.

Ran bundle install again and the migrations worked.

In the migration file add the following line:
  add_index :assets, :user_id  
As follows:
  def self.up
    create_table :assets do |t|
      t.integer :user_id
      t.timestamps
    end
    add_index :assets, :user_id
  end

  Flash messages are not working and Destroy action is not working. Decided to continue with S3 integrations first.
  
  