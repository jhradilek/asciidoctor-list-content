Gem::Specification.new do |s|
  # General information:
  s.name        = 'asciidoctor-list-content'
  s.version     = '0.1.1'
  s.summary     = 'List files included in an AsciiDoc document'
  s.description = 'A simple script that parses a supplied AsciiDoc file and prints all files included in it to standard output.'
  s.authors     = ['Jaromir Hradilek']
  s.email       = 'jhradilek@gmail.com'
  s.bindir      = 'bin'
  s.executables = ['list-content']
  s.files       = ['LICENSE', 'AUTHORS', 'README.md', 'TODO']
  s.homepage    = 'https://github.com/jhradilek/asciidoctor-list-content'
  s.license     = 'MIT'

  # Relevant metadata:
  s.metadata = {
    'homepage_uri'      => 'https://github.com/jhradilek/asciidoctor-list-content',
    'bug_tracker_uri'   => 'https://github.com/jhradilek/asciidoctor-list-content/issues',
    'documentation_uri' => 'https://github.com/jhradilek/asciidoctor-list-content/blob/main/README.md'
  }

  # Requirements:
  s.required_ruby_version = '>= 3.0.0'
  s.add_runtime_dependency 'asciidoctor', '~> 2.0', '>= 2.0.0'
end
