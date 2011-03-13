
require 'rubygems'
require 'bundler/setup'

require 'timed_counter'
require 'sinatra'
require 'json'

require 'haml'

set :sessions, false
set :logging, false
set :public, File.dirname(__FILE__) + '/public'
set :views, File.dirname(__FILE__) + '/views'

$redis = Redis.connect
$counter = TimedCounter.new($redis)

get "/" do
  @counters = $redis.smembers('$tc_list').sort

  haml :index
end

get "/counter/*" do
  @counter = params[:splat].join("/")
  @counters = $redis.smembers('$tc_list').sort

  @minutes = $counter.minutes(params[:splat], Time.now() - 60*60, 60)
  @hours = $counter.hours(params[:splat], Time.now() - (60*60*24), 24)

  haml :counter
end
