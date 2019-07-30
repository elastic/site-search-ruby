$:.push File.expand_path("../lib", __FILE__)
require "elastic/site-search/version"

Gem::Specification.new do |s|
  s.name        = "elastic-site-search-ruby"
  s.version     = Elastic::SiteSearch::VERSION
  s.authors     = ["Quin Hoxie", "Matt Riley"]
  s.email       = ["support@elastic.co"]
  s.homepage    = "https://github.com/elastic/site-search-ruby"
  s.summary     = %q{Official gem for accessing the Elastic Site Search API}
  s.description = %q{API client for accessing the Elastic Site Search API with no dependencies (on Ruby 1.9, JSON needed for Ruby 1.8).}
  s.licenses    = ['Apache-2.0']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 3.0.0'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'vcr', '~> 4.0.0'
  s.add_development_dependency 'webmock'
  if RUBY_VERSION < '1.9'
    s.add_runtime_dependency 'json'
  end
end
