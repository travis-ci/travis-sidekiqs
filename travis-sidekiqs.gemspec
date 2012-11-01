# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "travis-sidekiqs"
  gem.version       = "0.0.1"
  gem.authors       = ["Mathias Meyer"]
  gem.email         = ["meyer@paperplanes.de"]
  gem.description   = %q{Async, baby!}
  gem.summary       = %q{Async, baby!}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'sidekiq', '~> 2.5.0'
  gem.add_dependency 'sentry-raven'
end
