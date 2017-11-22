require_relative 'personal-mqtt'

class EM32 < MyMqtt
  attr_accessor :pub_topic

  def initialize (patient_id, session_id)
    @pub_topic = "/azienda/#{patient_id}/#{session_id}"

    super()
  end
end

class SERVER < MyMqtt
  attr_accessor :sub_topic

  def initialize
    @sub_topic = "/azienda/#"
    super
    self.subscribe(@sub_topic)
  end
end
