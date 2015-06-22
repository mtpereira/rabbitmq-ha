#!/usr/bin/env ruby

require "bunny"

config = {
  :host => ARGV[0],
  :user => "admin",
  :password => "admin",
  :vhost => "/",
}

conn = Bunny.new(config)
conn.start

ch = conn.create_channel

ch.default_exchange.publish("Hello World!", :routing_key => "hello", :durable => true)
puts " [x] Sent 'Hello World!'"

conn.close

