require 'rubygems'
require 'bundler/setup'

require 'timed_counter'

$redis = Redis.connect

$counter = TimedCounter.new($redis)

while true
  $stdout.write "."
  $counter.incr([:random, 100], rand(100))
  $counter.incr([:random, 50], rand(50))
  
  sleep(60)
end

