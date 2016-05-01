require "yaml"
require "curb"
require "json"

namespace :cassieq do
  desc "Start a CassieQ container in development mode"
  task :start_dev do
    start_cassieq
  end

  desc "Run RSpec test suite againts CassieQ dev container"
  task :test_client do
    start_cassieq { run_tests_and_quit }
  end
end

def start_cassieq
  system "docker pull paradoxical/cassieq"

  print "Starting CassieQ "
  pid = fork { `docker run -it -p 8080:8080 -p 8081:8081 paradoxical/cassieq dev` }

  until cassieq_ready?(host) do
    print "."
    sleep 5
  end
  puts " Ready!"

  prepare_account(host)

  yield if block_given?

  Process.wait(pid)
end

def host
  @host ||= if /darwin/ =~ RUBY_PLATFORM
    `docker-machine ip default`.chomp
  elsif /linux/ =~ RUBY_PLATFORM
    "0.0.0.0"
  end
end 

def run_tests_and_quit
  puts "Running RSpec tests"
  system "bundle exec rspec"

  puts "Stopping CassieQ"
  `docker stop $(docker ps -q -f status=running)`
end

def prepare_account(host)
  account = "test-account"
  claim_params = { "accountName" => account, "keyName" => "primary", "levels" => ["p","u", "a", "g"] }

  account_body = curl("http://#{host}:8081/admin/api/v1/accounts", account)
  claim_body = curl("http://#{host}:8081/admin/api/v1/permissions", claim_params)

  config = Hash.new.tap do |hash|
    hash["host"] = host
    hash["key"] = account_body["keys"]["primary"] if account_body["keys"]
    hash["provided_params"] = claim_body["queryParam"]
    hash["account"] = account
  end

  File.open("#{Dir.pwd}/spec/config.yml".to_s, "w") { |file| file.write(config.to_yaml) }

  puts "Account created"
end

def cassieq_ready?(host)
  begin
    response = Curl.get("http://#{host}:8080/")
    response.status == "200 OK"
  rescue Curl::Err::ConnectionFailedError, Curl::Err::RecvError
    false
  end
end

def curl(url, body)
  response = Curl.post(url, body.to_json) do |http|
    http.headers["Content-Type"] = "application/json"
    http.headers["Accept"] = "application/json"
  end

  JSON.parse(response.body_str)
end
