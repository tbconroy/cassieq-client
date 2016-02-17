Gem::Specification.new do |s|
  s.name = "cassieq_client"
  s.version = "0.0.0"
  s.date = "2016-02-15"
  s.summary = "CassieQ API Wrapper"
  s.description = "A simple wrapper for the CassieQ api"
  s.authors = ["Tom Conroy"]
  s.email = "tbconroy@gmail.com"
  s.files += Dir.glob("lib/**/*.rb")
  s.add_dependency "faraday", "~> 0.9.2"
  s.add_development_dependency "rspec", "~> 3.4.0"
  s.add_development_dependency "vcr", "~> 3.0.1"
  s.add_development_dependency "byebug", "~> 8.2.1"
  s.add_development_dependency "webmock", "~> 1.22.3"
  s.license = "MIT"
end
