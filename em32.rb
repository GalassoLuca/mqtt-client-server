require_relative 'personal-mqtt'

class EM32 < MyMqtt
  attr_accessor :pub_topic

  def initialize (patient_id, session_id)
    @pub_topic = "/azienda/#{patient_id}/#{session_id}"

    super()
  end
end



patient1 = EM32.new("patient1", "sessionXXX")
patient1.publish("First message")
patient1.publish("Second message")
patient1.publish("Third message")

patient2 = EM32.new("patient2", "sessionXXX")
patient2.publish("First message")
patient2.publish("Second message")
patient2.publish("Third message")

### Calling an explicit disconnect
patient1.disconnect
patient2.disconnect