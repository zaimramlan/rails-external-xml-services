class BuildUserXmlService
  def initialize(params)
    @user   = User.find(params[:id]) rescue nil
    @schema = eval("#{params[:adapter]}Schema.new") rescue nil
  end

  def call
    return nil unless @user && @schema

    xml_schema = @schema.endpoint.request
    schema     = Hash.from_xml(xml_schema).deep_symbolize_keys
    root       = schema[:sampleRequest]

    root[:User].update({
      Title: @user.title,
      Name:  @user.name,
      Email: @user.email
    })

    return schema.to_rootless_xml
  end
end
