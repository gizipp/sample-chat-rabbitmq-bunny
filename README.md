# sample-chat-rabbitmq-bunny
Sample simple chat using RabbitMQ (over Bunny)

## Usage
Assumed you already have Ruby, RabbitMQ and installed.

### Publishing & subscribing into certain topic
To publish message into topic, use this format ruby publisher.rb <topic> <nickname> <message>

```ruby
ruby publisher.rb general john "Hello all!"
# [x] Sent Hello all! into #general as john

ruby publisher.rb general jenny "Hello john, who are you?"
# [x] Sent Hello john, who are you? into #general as jenny

ruby publisher.rb secret_group jenny "All, anybody know who is john in general?"
ruby publisher.rb secret_group lisa "He is our new CEO"
ruby publisher.rb secret_group jenny "Ooops..."

# [x] Sent All, anybody know who is john in general? into #secret_group as jenny
# [x] Sent He is our new CEO into #secret_group as lisa
# [x] Sent Ooops... into #secret_group as jenny

```

### Subscribing into certain topic
To subscribe certain topic, use this format ruby subscriber.rb <topic>

```ruby
# Subscribing into 'general' topic
ruby subscriber.rb general

# Output
# [*] Waiting for messages from #general. To exit press CTRL+C
# [x] john: Hello all!
# [x] jenny: Hello john, how are you?

# Subscribing into 'secret_group' topic
ruby subscriber.rb secret_group

# Output
# [*] Waiting for messages from #secret_group. To exit press CTRL+C
# [x] jenny: All, anybody know who is john in general?
# [x] lisa: He is our new CEO
# [x] jenny: Ooops...

```
