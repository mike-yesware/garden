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
    client_id: 'brightness-test',
    )

client.connect

hue = 0

loop do
  client.publish('garden/big/display/hue/set', hue)

  hue += 1
  hue = 0 if hue > 255

  sleep 0.02
end