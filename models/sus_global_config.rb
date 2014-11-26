require_relative 'sus_global_config_descriptor'

include Java

class SUSGlobalConfig < Jenkins::Model::RootAction
  include Jenkins::Model
  include Jenkins::Model::DescribableNative
  describe_as Java.hudson.model.Descriptor, :with => SUSGlobalConfigDescriptor
end

Jenkins::Plugin.instance.register_extension(SUSGlobalConfig)
