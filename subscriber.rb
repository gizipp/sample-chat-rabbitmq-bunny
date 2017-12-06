#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

# Read argument from user input as topic
unless ARGV.length == 1
  STDERR.puts "Usage: #{$0} <topic>"
  exit 1
end
topic = ARGV[0]

# Create connection object
connection = Bunny.new

# Start the connection
connection.start

# Create a channel (incase it hasn't been made already)
channel  = connection.create_channel

# Create exchange as topic (read https://www.rabbitmq.com/tutorials/tutorial-five-ruby.html)
exchange = channel.topic("topic.chat")

# Create a queue based on topic
queue    = channel.queue(topic)

# Bind the queue with exchange based on topic
queue.bind(exchange, routing_key: topic)

puts " [*] Waiting for messages from ##{topic}. To exit press CTRL+C"

# FYI: Passing a `block: true` option stops the script from exiting prematurely.
begin
  queue.subscribe(block: true) do |delivery_info, properties, body|
    puts " [x] #{body}"
  end
rescue Interrupt => _
  # Close the channel and connection when exit
  channel.close
  connection.close
end
