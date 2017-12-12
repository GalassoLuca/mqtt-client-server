=begin
Logica del server che è in ascolto di tutti i dati della relativa azienda.
NOTA: in un primo momento non verrà implementata dato che il server farà il download dell'intero file della sessione
=end

require_relative 'personal-mqtt'

class SERVER < MyMqtt
end

server = SERVER.new
server.subscribe("azienda/#")


# Attesa dei dati di tutti i devices
while true do
  sleep 0.001
end