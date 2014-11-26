# Single Use Slave plugin for Jenkins

This plugin will mark nodes as offline when a job completes on them.  It will
do this only for nodes with one of the labels specified in the Jenkins global
configuration.  One or more labels may be specified in the global
configuration.  

This plugin is intended to be used with external tools like
[Nodepool](http://ci.openstack.org/nodepool.html), which has the ability to
spin up slaves on demand and then reap them when Jenkins has run a job on them.
This plugin is needed because there is a race condition between when the job
completes and when the external tool is able to reap the node.  This plugin
addresses the race condition by intercepting the build complete notifications
generated internally to Jenkins and offlining relevant nodes before another job
can be schedule on them.

## Development

For development and to see this plugin in a test Jenkins server:

```
$ bundle install
$ jpi server
```

The [Mock Slave
Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Mock+Slave+Plugin) is
useful for testing this in a development environment.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
