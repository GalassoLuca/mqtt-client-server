=begin
Logica del frontend che implementa le interazioni con il medico quali:
 - avvio e interruzione della sessione
 - ricezione e visualizzazione dei dati dei pazienti
=end

require_relative 'personal-mqtt'

class FRONT_END < MyMqtt
end

front_end = FRONT_END.new

# Elenco pazienti della nuova sessione
pazienti = ['mt_serial_1', 'mt_serial_2']
id_sessione = 'sessionXXX'

# Sottoscrizione al topic della sessione appena creata
front_end.subscribe("azienda/+/#{id_sessione}/#")

# Invio della configurazione ai relativi devices
pazienti.collect {|p|
  front_end.publish("azienda/#{p}", id_sessione)
}

# Paziente su una sessione differente
# NOTA: questo paziente sarà inizializzato da un'altro front
front_end.publish('azienda/mt_serial_3', 'sessionYYY')


# Attesa dei dati dei devices della sessione specificata
while true do
  sleep 0.001
end