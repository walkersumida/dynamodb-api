lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dynamodb/api/version'

Gem::Specification.new do |spec|
  spec.name          = 'dynamodb-api'
  spec.version       = Dynamodb::Api::VERSION
  spec.authors       = ['WalkerSumida']
  spec.email         = ['walkersumida@gmail.com']

  spec.summary       = %q(aws dynamodb api)
  spec.description   = %q(aws dynamodb api)
  spec.homepage      = 'https://github.com/walkersumida/dynamodb-api'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'aws-sdk', '>= 2'
  spec.add_runtime_dependency('activesupport', '>= 5')

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop-airbnb'
  spec.add_development_dependency 'appraisal'
end
