# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ipgeobase/version"

Gem::Specification.new do |s|
  s.name        = "ipgeobase"
  s.version     = Ipgeobase::VERSION
  s.authors     = ["Avramov Vsevolod"]
  s.email       = ["gsevka@gmail.com"]
  s.homepage    = "http://github.com/vsevolod/ipgeobase"
  s.description = "upload archive from IPGeoBase.ru to your project"

  s.rubyforge_project = "ipgeobase"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "ancestry"
  s.required_ruby_version = '>= 1.9.2'
end
