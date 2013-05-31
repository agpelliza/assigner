Gem::Specification.new do |s|
  s.name        = 'assigner'
  s.version     = '0.0.0'
  s.executables << 'assigner'
  s.date        = '2013-05-29'
  s.summary     = "Assign!"
  s.description = "A simple assigner gem"
  s.authors     = ["Agustin Pelliza"]
  s.email       = 'agpelliza@gmail.com'
  s.homepage    =
    'http://rubygems.org/gems/assigner'

  s.files = Dir[
    "LICENSE",
    "CHANGELOG",
    "README.md",
    "Rakefile",
    "lib/**/*.rb",
    "*.gemspec",
    "test/*.*"
  ]
end