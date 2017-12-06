#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

# Read argument from user input as topic, nickname, and message
unless ARGV.length == 3
  STDERR.puts "Usage: #{$0} <topic> <nickname> <message>"
  exit 1
end
topic, nickname, message = ARGV[0], ARGV[1], ARGV[2]

# Create connection object
connection = Bunny.new

# Start the connection
connection.start

# Create a channel (incase it hasn't been made already)
channel   = connection.create_channel

# Create exchange as topic (read https://www.rabbitmq.com/tutorials/tutorial-five-ruby.html)
exchange  = channel.topic("topic.chat")

# Publish message on exchange with topic as routing key
msg  = "#{nickname}: #{message}"
exchange.publish(msg, routing_key: topic)
puts " [x] Sent #{message} into ##{topic} as #{nickname}"

# Close the connection
connection.close
