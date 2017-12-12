=begin
Logica del frontend che implementa le interazioni con il medico quali:
 - avvio e interruzione della sessione
 - ricezione e visualizzazione dei dati dei pazienti
=end

require_relative 'personal-mqtt'

class FRONT_END < MyMqtt
  attr_accessor :sub_topic

  def initialize
    @sub_topic = "/azienda/+/sessionXXX"
    super
    self.subscribe(@sub_topic)
  end
end



# Elenco pazienti che iniziano la sessione

server = FRONT_END.new

while true do 
	sleep 0.001
end