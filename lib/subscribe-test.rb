require 'paho-mqtt'
require 'yeti_logger'

include YetiLogger
YetiLogger.configure do |config|
  config.logger = Logger.new(STDOUT)
end

client = PahoMqtt::Client.new(
    host: '192.168.7.200',
    port: 1883,
    persistent: true,
    reconnect_limit: -1,
    reconnect_delay: 1,
    client_id: 'subscribe-test',
    )

client.connect

client.on_message do |message|
   log_debug message.inspect
end

client.subscribe(['#'])

sleep 1000