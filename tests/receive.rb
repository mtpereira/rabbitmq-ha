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
q  = ch.queue("hello", :durable => true)

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
q.subscribe(:block => true) do |delivery_info, properties, body|
  puts " [x] Received #{body}"
  delivery_info.consumer.cancel
end

conn.close

