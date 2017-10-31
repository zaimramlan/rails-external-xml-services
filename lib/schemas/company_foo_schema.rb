class CompanyFooSchema < BaseSchema
  def initialize
    @endpoint_request  = load_file_from('company_foo', ['endpoint'], 'request.xml')
    @endpoint_response = load_file_from('company_foo', ['endpoint'], 'response.xml')
  end

  def endpoint
    xml            = {}
    xml[:request]  = @endpoint_request
    xml[:response] = @endpoint_response
    return xml.to_object
  end
end
