#!/usr/bin/env ruby

require "bunny"

config = {
  :host => "mq2.hack.aton",
  :user => "admin",
  :password => "admin",
  :vhost => "/",
}

conn = Bunny.new(config)
conn.start

ch = conn.create_channel
q  = ch.queue("hello")

ch.default_exchange.publish("Hello World!", :routing_key => q.name)
puts " [x] Sent 'Hello World!'"

conn.close

