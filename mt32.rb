=begin
Logica del device MT32
=end

require_relative 'personal-mqtt'

class MT32 < MyMqtt
  attr_accessor :topic_prefix
  attr_accessor :waiting_message

  def initialize (mqtt_serial)
    super()
    @waiting_message = true

    # old_on_message = self.on_message

    self.on_message do |message|
      puts 'Configuration received'
      @topic_prefix += "/#{message.payload}"

      # Restoring the general on_message (configuration received)
      # self.on_message = self.on_message()
      @waiting_message = false
    end

    @topic_prefix = "azienda/#{mqtt_serial}"
    self.subscribe(@topic_prefix)
  end

  def publish(topic, payload = '')
    super("#{@topic_prefix}/#{topic}", payload)
  end
end


device1 = MT32.new('mt_serial_1')
device2 = MT32.new('mt_serial_2')
device3 = MT32.new('mt_serial_3')

# Wait all configurations
while device1.waiting_message or device2.waiting_message or device3.waiting_message do
  sleep 0.001
end

count = 0
while true do
  count = count + 1
  device1.publish('ECG', "ECG row data #{count}")
  device2.publish('ECG', "ECG row data #{count}")
  device3.publish('ECG', "ECG row data #{count}")
  sleep 1
end

### Calling an explicit disconnect
device1.disconnect