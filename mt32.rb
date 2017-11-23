require_relative 'personal-mqtt'

class MT32 < MyMqtt
  attr_accessor :pub_topic

  def initialize (patient_id, session_id)
    @pub_topic = "/azienda/#{patient_id}/#{session_id}"

    super()
  end
end



patient1 = MT32.new("patient1", "sessionXXX")
patient1.publish("First message")
patient1.publish("Second message")
patient1.publish("Third message")

patient2 = MT32.new("patient2", "sessionXXX")
patient2.publish("First message")
patient2.publish("Second message")
patient2.publish("Third message")

### Calling an explicit disconnect
patient1.disconnect
patient2.disconnect


### Different session 
patient3 = MT32.new("patient3", "sessionYYY")
patient3.publish("First message")
patient3.publish("Second message")
patient3.publish("Third message")

### Calling an explicit disconnect
patient3.disconnect