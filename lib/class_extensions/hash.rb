class Hash
  # convert a hash into object
  # that can be called via chaining methods
  def to_object
    JSON.parse(self.to_json, object_class: OpenStruct)
  end

  # convert a hash into xml without being enclosed by
  # a 'root' element
  def to_rootless_xml(options = {})
    require "active_support/builder" unless defined?(Builder)

    options = options.dup
    options[:indent]  ||= 2
    options[:builder] ||= Builder::XmlMarkup.new(indent: options[:indent])

    builder = options[:builder]
    builder.instruct! unless options.delete(:skip_instruct)

    each { |key, value| ActiveSupport::XmlMini.to_tag(key, value, options) }
    yield builder if block_given?
    builder.target!    
  end  
end
