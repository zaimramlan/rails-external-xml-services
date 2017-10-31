require 'spec_helper'
require 'rails_helper'
require 'webmock/rspec'
include WebMock::API

describe CompanyFooAdapter, :clean_as_group => true do
  before(:all) do
    user     = create(:user)
    @adapter = CompanyFooAdapter.new(user_id: user.id)
  end

  describe '#submit_request' do 
    describe 'with an existing user,' do
      describe 'after XML sent to the server,' do
        before(:each) do
          stub_request(:post, ENV['COMPANY_FOO_ENDPOINT']).
            with(:headers => {'Content-Type' => 'text/xml'}).
              to_return(:status => response_status, :body => response_body, :headers => {})
        end

        let(:response) { @adapter.submit_request }
        let(:response_body) {
          schema              = CompanyFooSchema.new.endpoint.response
          body                = Hash.from_xml(schema).deep_symbolize_keys
          root                = body[:sampleResponse]
          root[:Result]       = result_message
          root[:ErrorMessage] = error_message
          body.to_rootless_xml
        }

        context 'when request is successful,' do
          let(:response_status) { 200 }
          let(:result_message)  { 'OK' }
          let(:error_message)   { nil }

          it 'it receives an \'OK\' result' do
            body = Hash.from_xml(response.body).to_object.sampleResponse
            expect(response.code).to eq(200)
            expect(body.Result).to eq('OK')
          end

          it 'it does not receive any error messages' do
            body = Hash.from_xml(response.body).to_object.sampleResponse
            expect(body.ErrorMessage).to be_blank
          end
        end

        context 'when request is unsuccessful,' do
          let(:response_status) { 400 }
          let(:result_message)  { 'ERROR' }
          let(:error_message)   { Faker::Lorem.sentence }        

          it 'it receives an \'ERROR\' result' do
            body = Hash.from_xml(response.body).to_object.sampleResponse
            expect(response.code).to eq(400)
            expect(body.Result).to eq('ERROR')
          end

          it 'it receives an error message' do
            body = Hash.from_xml(response.body).to_object.sampleResponse
            expect(body.ErrorMessage).not_to be_blank
          end
        end
      end
    end

    describe 'with a non-existing user,' do
      it 'returns nothing' do 
        response = CompanyFooAdapter.new(user_id: 99).submit_request
        expect(response).to be_nil
      end
    end
  end
end
