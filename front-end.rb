require_relative 'personal-mqtt'

class FRONT_END < MyMqtt
  attr_accessor :sub_topic

  def initialize
    @sub_topic = "/azienda/+/sessionXXX"
    super
    self.subscribe(@sub_topic)
  end
end




server = FRONT_END.new

while true do 
	sleep 0.001
end