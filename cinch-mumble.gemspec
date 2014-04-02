# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "cinch-mumble"
  spec.version       = '0.0.2'
  spec.authors       = ['Liru']
  spec.email         = ''
  spec.summary       = 'A Mumble plugin for Cinch that allows users to play/trigger sound clips and music via IRC.'
  spec.description   = spec.summary
  spec.homepage      = "http://www.gihub.com/Liru/cinch-mumble"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency('cinch', '~> 2.0')
  spec.add_dependency('mumble-ruby', '~> 1.0')
  spec.add_dependency('opus-ruby')
  spec.add_dependency('ruby-mpd')

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
