require 'spec_helper'
require 'rails_helper'

describe CompanyFooSchema do
  describe '#endpoint' do
    let (:schema)          { CompanyFooSchema.new }
    let (:request_schema)  { BaseSchema.new.load_file_from('company_foo', ['endpoint'], 'request.xml') }
    let (:response_schema) { BaseSchema.new.load_file_from('company_foo', ['endpoint'], 'response.xml') }

    it 'returns an object with the request schema for the endpoint' do
      expect(schema.endpoint.request).to eq(request_schema)
    end

    it 'returns an object with the response schema for the endpoint' do
      expect(schema.endpoint.response).to eq(response_schema)
    end
  end
end
