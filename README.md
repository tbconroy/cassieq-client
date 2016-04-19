#CassieQ Client
[![Gem Version](https://badge.fury.io/rb/cassieq-client.svg)](https://badge.fury.io/rb/cassieq-client)
[![Build Status](https://travis-ci.org/tronroy/cassieq-client.svg?branch=master)](https://travis-ci.org/tronroy/cassieq-client)

A Ruby wrapper for the [CassieQ](https://github.com/paradoxical-io/cassieq) API

##Installation
Install from RubyGems:
```
gem install cassieq-client
```

Require statement:
```
require "cassieq/client"
```

##Usage

###Create a client
With signed request authentication:
```
client = Cassieq::Client.new do |config| 
  config.host = "192.168.99.100"
  config.account = "account_name"
  config.key = "7dCFl6xxco1NIQSxSpseW5olftHHxHlc6Q12DY5VkBkCCs8_q3JrvYgPZapUSJ6PcaQDElunMsEFwDuOi6tQFQ"
end
=> #<Cassieq::Client:0x007fdc4b10ab10 ... >
```
With signed query string authentication, i.e. "claims":
```
client = Cassieq::Client.new do |config|
  config.host = "192.168.99.100"
  config.account = "account_name"
  config.provided_params = "auth=g&sig=9aw5gn22G-WN-RRBSQPR1zHgZHbiuv8SsFeODevDiqs"
end
=> #<Cassieq::Client:0x007f839b840118 ... >
```
Read more about CassieQ's authentication [here](https://github.com/paradoxical-io/cassieq/wiki/Authentication).

###Create a queue
```
client.create_queue(queue_name: "my_queue", bucket_size: 15, max_delivery_count: 10)
# => true
```
See CassieQ's API [documentation](https://github.com/paradoxical-io/cassieq/wiki/api) for all queue creation options.

###Add message to queue
```
client.publish_message("my_queue", "message content")
# => true
```

###Get message from a queue
```
message_object = client.next_message("my_queue")
# => #<Cassieq::Message:70292061736200>

message_object.message = "message content"
message_object.deliver_count = 0
```

###Ack message
```
client.ack_message("my_queue", message_object.pop_receipt)
# => true
```
