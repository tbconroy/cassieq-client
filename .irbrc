require_relative "lib/cassieq/client"
require "yaml"

CONFIG = YAML.load_file("#{Dir.pwd}/spec/config.yml")

def client
  Cassieq::Client.new do |c|
    c.host = CONFIG["host"]
    c.key = CONFIG["key"]
    c.account = CONFIG["account"]
  end
end
