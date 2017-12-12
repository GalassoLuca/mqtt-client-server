=begin
Generale implementazione di PAHO in modo da visualizzare lo scambio di messaggi MQTT
=end

require 'paho-mqtt'

# abstract class
class MyMqtt < PahoMqtt::Client
  attr_accessor :pub_topic
  attr_accessor :sub_topic
  attr_accessor :waiting_puback
  attr_accessor :waiting_suback

  def initialize
    super
    @waiting_puback = false
    @waiting_suback = false

    # self.on_connack = proc { puts "#{self.class.name} successfully connected\n\tPub topic: #{pub_topic}\n\tSub topic: #{sub_topic} " }
    self.on_connack = proc { puts "#{self.class.name} successfully connected" }
    
    self.on_puback do
      @waiting_puback = false
      puts "#{self.class.name} publish ack received"
    end
    
    self.on_suback do
      @waiting_suback = false
      puts "#{self.class.name} subscribe ack received"
    end

    self.on_message do |message|
      puts " --- #{message.id} ---"
      puts "Listening topic #{message.topic}"
      puts "Payload \t#{message.payload}"
      puts "Payload.size \t#{message.payload.size}"
    end

    self.connect('localhost', 1883)
    # self.connect('iot.eclipse.org', 1883)
  end

  def subscribe(*topics)
    @waiting_suback = true
    super(*topics)
    
    while @waiting_suback do
      sleep 0.001
    end
  end

  def publish(payload = "")
    puts "Publish on topic "

    @waiting_puback = true
    super(@pub_topic, payload, false, 1)

    # should be removed to use callback in asynchronous mode
    while @waiting_puback do
      sleep 0.001
    end
  end
end
