require 'paho-mqtt'
require 'yeti_logger'

include YetiLogger
YetiLogger.configure do |config|
  config.logger = Logger.new(STDOUT)
end

FLOWERS = %w(
big
biglittle
bluebelle
poinsettia
purple
little
smiley
spike
spud
starfish
sunflower
swirl
tiny
ugly
yellow
)

client = PahoMqtt::Client.new(
    host: '192.168.0.200',
    port: 1883,
    persistent: true,
    reconnect_limit: -1,
    reconnect_delay: 1,
    client_id: 'set-all-pattern',
    )

client.connect

pattern = 6

FLOWERS.each do |flower|
  client.publish("garden/#{flower}/display/pattern/set", pattern)
end

sleep 5