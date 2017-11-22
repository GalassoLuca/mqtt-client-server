require_relative 'classes'


server = SERVER.new

patient1 = EM32.new("patient1", "sessionXXX")
patient1.publish("First message")
patient1.publish("Second message")
patient1.publish("Third message")

patient2 = EM32.new("patient2", "sessionXXX")
patient2.publish("First message")
patient2.publish("Second message")
patient2.publish("Third message")


### Waiting to assert that the message is displayed by on_message callback
sleep 1

### Calling an explicit disconnect
server.disconnect
patient1.disconnect
patient2.disconnect




