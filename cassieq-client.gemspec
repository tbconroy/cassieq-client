Gem::Specification.new do |s|
  s.name = "cassieq-client"
  s.version = "0.0.1"
  s.date = "2016-02-15"
  s.summary = "CassieQ Client"
  s.description = "A simple wrapper for the CassieQ API"
  s.authors = ["Tom Conroy"]
  s.email = "tbconroy@gmail.com"
  s.homepage = "https://github.com/tronroy/cassieq-client"
  s.files += Dir.glob("lib/**/*.rb")
  s.add_dependency "activesupport", "~>4.2"
  s.add_dependency "faraday", "~> 0.9"
  s.add_dependency "faraday_middleware", "~>0.10"
  s.add_development_dependency "rspec", "~> 3.4"
  s.add_development_dependency "vcr", "~> 3.0"
  s.add_development_dependency "byebug", "~> 8.2"
  s.add_development_dependency "webmock", "~> 1.22"
  s.license = "MIT"
end
