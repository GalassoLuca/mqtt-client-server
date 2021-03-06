=begin
Generale implementazione di PAHO in modo da visualizzare lo scambio di messaggi MQTT
=end

require 'paho-mqtt'

# abstract class
class MyMqtt < PahoMqtt::Client
  attr_accessor :waiting_puback
  attr_accessor :waiting_suback

  def initialize
    super
    @waiting_puback = false
    @waiting_suback = false

    # INIT CALLBACK
    # self.on_connack = proc { puts "#{self.class.name} successfully connected " }
    self.on_connack = proc { puts "#{self.class.name} successfully connected" }
    
    self.on_puback do
      puts "#{self.class.name} publish ack received"
      @waiting_puback = false
    end
    
    self.on_suback do
      puts "#{self.class.name} subscribe ack received"
      @waiting_suback = false
    end

    self.on_message do |message|
      puts "Message topic #{message.topic}"
      puts "Payload \t#{message.payload}"
      # puts "Payload.size \t#{message.payload.size}"
    end

    # CONNECTING TO THE BROKER
    # ip = 'iot.eclipse.org'
    # port = 1883
    ###
    # ip = 'broker.mqttdashboard.com'
    # port = 1883
    ###
    ip = 'localhost'
    port = 1883
    
    puts "Connecting #{ip} @ #{port}"
    self.connect(ip, port)
  end

  def subscribe(*topics)
    @waiting_suback = true
    super(*topics)
    
    while @waiting_suback do
      sleep 0.001
    end
    puts "Subscribed on topic #{topics[0]}"
  end

  def publish(topic, payload = '')
    puts "Publish '#{payload}' on topic '#{topic}'"

    @waiting_puback = true
    super(topic, payload, false, 1)

    # should be removed to use callback in asynchronous mode
    while @waiting_puback do
      sleep 0.001
    end
  end
end
