# Comunicazione MQTT

Comunicazione tra MT32, front-end e il server

Il codice generato ha lo scopo di chiarire i concetti base della comunicazione in oggetto, dando spunto alla possibile implementazione finale

### Descrizione
Paho-mqtt è stato implementato principalmente nel file *./personal-mqtt.rb*, in modo da stampare messaggi chiari durante l'esecuione e, per chiarezza e controllo, i messaggi di tutti i client mqtt vengono inviati in sequenza  

Inoltre la classe presente nel file *mt32.rb*, ovvero il device mt32, come primo messaggio attende la configurazione (in cui troverà l'id della sessione). In tale file vengono creati 3 client che attendono la configurazione e, una volta che **tutti** l'hanno ricevuta, inviano un messaggio ogni secondo.

Infine il front-end, una volta avviato, ascolta sul topic della sessione con id ***sessionXXX*** per poi inviare la configurazione a due client con tale sessione, e ad un terzo con una sessione differente (ovvero il front-end non riceverà i dati di quest'ultimo). Questo solo a titolo di esempio dato che la configurazione di ogni device verrà inviata da front-end differenti (oppure dal server)

### Prerequisiti

È necessario installare Ruby e [paho-mqtt](https://github.com/RubyDevInc/paho.mqtt.ruby)  

### Broker

Per la scelta del broker è possibile utilizzare iot.eclipse.org oppure avviare un broker locale come [Mosquitto](https://mosquitto.org/) che è possibile installarlo tramite brew

```
brew install mosquitto
```
e avviarlo con
```
brew services start mosquitto
```

### Esecuzione

Per l'esecuzione devono essere eseguiti in ordine il server, i dispositivi MT32 (che attendono la configurazione) e infine il front-end (che invia la configurazione)

```
ruby server.rb
```
```
ruby mt32.rb
```
```
ruby front-end.rb
```

### TODO

Non è stata implementato l'invio della configurazione qualora il device venga acceso dopo la creazione della sessione (basta che il front-end si sottoscriva al topic *azienda/+* e, alla ricezione di un messaggio, invia la configurazione se presente)