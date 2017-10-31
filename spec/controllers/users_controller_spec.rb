require 'spec_helper'
require 'rails_helper'
require 'webmock/rspec'
include WebMock::API

describe UsersController, :type => :controller do
  describe 'POST #create' do
    context 'when user is successfully saved,' do
      before(:each) do 
        stub_request(:post, ENV['COMPANY_FOO_ENDPOINT']).
          with(:headers => {'Content-Type' => 'text/xml'}).
            to_return(:status => 200, :body => 'OK', :headers => {})
        post :create, :params => {:user => attributes_for(:user)}
      end

      it 'creates a new user' do
        expect(User.count).to eq(1)
      end

      it 'redirects to user\'s show page' do
        id = User.first.id
        expect(response).to redirect_to(user_path(id))
      end

      it 'passes a success notice' do
        expect(subject.notice).to eq('User was successfully created.')
      end
    end

    context 'when user is not successfully saved,' do
      before(:each) { post :create, :params => {:user => attributes_for(:user, :title => '')} }

      it 'does not create a new user' do
        expect(User.count).to eq(0)
      end

      it 'does not redirect to another page' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
