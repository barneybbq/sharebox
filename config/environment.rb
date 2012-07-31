# Load the rails application
require File.expand_path('../application', __FILE__)

# Load app vars from local file
s3_env = File.join(Rails.root, 'config', 's3.rb')
load(s3_env) if File.exists?(s3_env)

# Initialize the rails application
Sharebox::Application.initialize!

#Formatting DateTime to look like "20/01/2011 10:28PM"  
Time::DATE_FORMATS[:default] = "%d/%m/%Y %l:%M%p"
