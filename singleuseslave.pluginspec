Jenkins::Plugin::Specification.new do |plugin|
  plugin.name = "singleuseslave"
  plugin.display_name = "Single Use Slave Plugin"
  plugin.version = '1.0.0'
  plugin.description = <<-EOS
    This plugin will allow taking slaves with specific labels offline when a
    job completes
  EOS

  plugin.url = 'https://wiki.jenkins-ci.org/display/JENKINS/Single+Use+Slave+Plugin'

  plugin.developed_by "claytononeill", "Clayton O'Neill <clayton@oneill.net>"
  plugin.uses_repository :github => "jenkinsci/singleuseslave-plugin"
  plugin.depends_on 'ruby-runtime', '0.12'
end
