Jenkins::Plugin::Specification.new do |plugin|
  plugin.name = "singleuseslave"
  plugin.display_name = "Single Use Slave Plugin"
  plugin.version = '0.1.1'
  plugin.description = 'Allows taking slaves offline after a build runs on them'

  plugin.url = 'https://wiki.jenkins-ci.org/display/JENKINS/Single+Use+Slave+Plugin'

  plugin.developed_by "claytononeill", "Clayton O'Neill <clayton@oneill.net>"
  plugin.uses_repository :github => "dvorak/jenkins-plugin-singleuseslave"
  plugin.depends_on 'ruby-runtime', '0.12'
end
