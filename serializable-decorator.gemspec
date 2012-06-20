# -*- encoding: utf-8 -*-
require File.expand_path('../lib/serializable_decorator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andy Caldwell"]
  gem.email         = ["andy.m.caldwell@googlemail.com"]
  gem.description   = %q{A serializable decorator}
  gem.summary       = %q{A concrete decorator implementation that can be serialized to JSON with the decoration included alongside the original attributes}
  gem.homepage      = "https://github.com/bossmc/serializable-decorator"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "serializable_decorator"
  gem.require_paths = ["lib"]
  gem.version       = Delegators::SerializableDecorator::VERSION

  gem.add_runtime_dependency "json"

  gem.add_development_dependency "rspec"
end
