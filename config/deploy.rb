# Use RVM plugin
#$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

#require 'rvm/capistrano'
require 'bundler/capistrano'

# The timestamp normalization feature tries to find assets in the directories
# public/{images,javascript,stylesheets}, but that is not the place the new
# Rails asset pipeline stores them in. Turning the timestamp normalization off
# avoids several messages during deployment that warn about the non-existence
# of the expected asset directories.
set :normalize_asset_timestamps, false

set :application, "march_madness"
#set :repository,  "set your repository location here"

set :scm, :none
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set(:repository, ".")

# Sudo requires password - try the following
set :deploy_via, :copy

set :deploy_to, "/var/www-rails/march_madness"

role :web, "96.0.255.249"                          # Your HTTP server, Apache/etc
role :app, "96.0.255.249"                          # This may be the same as your `Web` server
role :db,  "96.0.255.249", :primary => true # This is where Rails migrations will run
role :db,  "96.0.255.249"

default_run_options[:pty] = true

set :user, 'march_madness'
set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end