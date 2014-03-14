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
  gem.add_dependency 'sidekiq', '> 2.8.0'
  # TODO this seems to force every app that uses travis-core to also use
  # raven for error reporting, is that what want?
  # gem.add_dependency 'sentry-raven'
end
