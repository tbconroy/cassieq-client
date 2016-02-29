Gem::Specification.new do |s|
  s.name = "cassieq-client"
  s.version = "0.1.0"
  s.date = "2016-02-15"
  s.summary = "CassieQ Client"
  s.description = "A Ruby API wrapper for CassieQ"
  s.authors = ["Tom Conroy"]
  s.email = "tbconroy@gmail.com"
  s.homepage = "https://github.com/tronroy/cassieq-client"
  s.files += Dir.glob("lib/**/*.rb")
  s.required_ruby_version = '>= 1.9.3'
  s.add_dependency "activesupport", "~>4.2"
  s.add_dependency "faraday", "~> 0.9"
  s.add_dependency "faraday_middleware", "~>0.10"
  s.license = "MIT"
end
