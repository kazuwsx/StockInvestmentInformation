# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = Rails.env.to_sym
rails_root = Rails.root.to_s

set :environment, rails_env
set :output, "#{rails_root}/log/cron.log"
set :chronic_options, hours24: true

every 1.days, at: '4:30 am' do
  runner "/lib/batch/periodicScraping.rb"
end
