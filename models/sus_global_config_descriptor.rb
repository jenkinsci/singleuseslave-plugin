include Java

java_import Java.hudson.BulkChange
java_import Java.hudson.model.listeners.SaveableListener

class SUSGlobalConfigDescriptor < Jenkins::Model::DefaultDescriptor

  attr_accessor :sus_labels

  def initialize(*)
    super
    load

    $stderr.puts "LOADED LABELS #{sus_labels}"
  end


  # @see hudson.model.Descriptor#load()
  def load
    return unless configFile.file.exists()
    from_xml(File.read(configFile.file.canonicalPath))
  end


  # @see hudson.model.Descriptor#save()
  def save
    return if BulkChange.contains(self)

    begin
      File.open(configFile.file.canonicalPath, 'wb') { |f| f.write(to_xml) }
      SaveableListener.fireOnChange(self, configFile)
    rescue => e
      logger.log(Level::SEVERE, "Failed to save #{configFile}: #{e.message}")
    end
  end


  def configure(req, form)
    parse(form)

    save
    true
  end


  private


    def logger
      @logger ||= Logger.getLogger(SUSGlobalConfigDescriptor.class.name)
    end


    def from_xml(xml)
      @sus_labels = xml.scan(/<sus_labels>(.*)<\/sus_labels>/).flatten.first
    end


    def to_xml
      str = ""
      str << "<?xml version='1.0' encoding='UTF-8'?>\n"
      str << "<#{id} plugin=\"single_user_slave\">\n"
      str << "  <sus_labels>#{sus_labels}</sus_labels>\n"
      str << "</#{id}>\n"
      str
    end


    def parse(form)
      @sus_labels = form["sus_labels"]
    end

end
