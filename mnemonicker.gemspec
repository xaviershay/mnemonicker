# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mnemonicker/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Xavier Shay"]
  gem.email         = ["contact@xaviershay.com"]
  gem.description   =
    %q{An aid for remembering numbers}
  gem.summary       = %q{
    Encoder and decoder for the mnemonic major system for remembering numbers.
  }
  gem.homepage      = "http://github.com/xaviershay/mnemonicker"

  gem.executables   = []
  gem.required_ruby_version = '>= 1.9.0'
  gem.files         = Dir.glob("{test,lib}/**/*.rb") + %w(
                        README.md
                        HISTORY.md
                        mnemonicker.gemspec
                      )
  gem.test_files    = Dir.glob("test/**/*.rb")
  gem.name          = "mnemonicker"
  gem.require_paths = ["lib"]
  gem.bindir        = "bin"
  gem.executables  << "mnemonicker"
  gem.version       = Mnemonicker::VERSION
  gem.has_rdoc      = false
  gem.add_dependency 'rubyfish'
end
