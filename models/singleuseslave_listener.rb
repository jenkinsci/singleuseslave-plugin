java_import 'hudson.slaves.OfflineCause'
java_import Java.java.util.logging.Logger
java_import Java.java.util.logging.Level

# Receive notification of build events
#
# SingleuseslaveListener is always Jenkins-wide, so once registered 
# it gets notifications for every build that happens in this Hudson.
#
# This class will receive callbacks
# when builds are started, completed, deleted, etc...
#
# To receive a callback, override the method with the same name as
# the event. E.g.
#
#     class MyRunListener
#       include Jenkins::Listeners::RunListener
#
#       def started(build, listener)
#         puts "build.inspect started!"
#       end
#     end
#
class SingleuseslaveListener
  include Jenkins::Listeners::RunListener

  attr_accessor :labels

  def logger
     @logger ||= Logger.getLogger(self.class.name)
  end

  def fix_empty(s)
    s == "" ? nil : s
  end

  def get_label_config
    instance = Java.jenkins.model.Jenkins.getInstance()
    config = instance.getDescriptor(SUSGlobalConfigDescriptor.java_class)
    label_raw = fix_empty(config.sus_labels) 

    # labels should be comma delimited and we want to remove any leading or
    # trailing whitespace.
    labels = label_raw.split(',')
    return labels.map { |x| x.strip }
  end

  # Called after a build is completed.
  #
  # @param [Jenkins::Model::Build] the completed build
  # @param [Jenkins::Model::TaskListener] the task listener for this build
  def completed(build, listener)
    sus_labels = get_label_config

    node = build.get_built_on
    node_labels = []
    node.get_assigned_labels.each do |label|
      node_labels << label.name
    end

    intersecting_labels = sus_labels & node_labels
    if not intersecting_labels.empty?
      computer = node.to_computer
      logger.info("Taking single use slave '#{computer.get_display_name}' offline " +
        "because of labels (" + intersecting_labels.join(', ') + ")")
      cause = OfflineCause::ByCLI.new('Offlined by Single Use Slave Plugin')

      computer.set_temporarily_offline(true, cause)
    end  
  end
end
