require 'spec_helper'
require 'rails_helper'

describe BuildUserXmlService, :clean_as_group => true do
  before(:all)  { create(:user) }
  let(:service) { BuildUserXmlService.new(id: user_id, adapter: adapter) }

  context 'when user and schema exists,' do
    let(:sample_user_xml) {
      user = User.first.attributes.except('id', 'created_at', 'updated_at').transform_keys(&:titleize)
      xml  = {'User' => user}.to_xml(:root => 'sampleRequest')
      return xml
    }
    let(:user_id) { User.first.id }
    let(:adapter) { 'CompanyFoo' }

    it 'returns the user attribute values in XML' do
      expect(service.call).to eq(sample_user_xml)
    end
  end

  context 'when user is nil,' do
    let(:user_id) { nil }
    let(:adapter) { 'CompanyFoo' }

    it 'does not return anything' do
      expect(service.call).to be_nil
    end
  end

  context 'when schema is nil,' do
    let(:user_id) { User.first.id }
    let(:adapter) { nil }

    it 'does not return anything' do
      expect(service.call).to be_nil
    end
  end
end
