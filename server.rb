require_relative 'personal-mqtt'

class SERVER < MyMqtt
  attr_accessor :sub_topic

  def initialize
    @sub_topic = "/azienda/#"
    super
    self.subscribe(@sub_topic)
  end
end




server = SERVER.new

while true do 
	sleep 0.001
end