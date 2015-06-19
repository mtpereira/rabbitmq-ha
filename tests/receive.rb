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

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
q.subscribe(:block => true) do |delivery_info, properties, body|
  puts " [x] Received #{body}"
  delivery_info.consumer.cancel
end

conn.close

