# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'travis-sidekiqs'
  gem.version       = '0.0.1'
  gem.authors       = ['Mathias Meyer']
  gem.email         = ['meyer@paperplanes.de']
  gem.summary       = %q{Async, baby!}
  gem.description   = gem.summary + '  No, really!'
  gem.homepage      = 'https://github.com/travis-ci/travis-sidekiqs'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\0")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w{lib}
  gem.add_dependency 'sidekiq'
  gem.add_dependency 'redis-namespace'
end
