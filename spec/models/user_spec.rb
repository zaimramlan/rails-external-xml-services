require 'spec_helper'
require 'rails_helper'

describe User do
  it 'is valid with title, name and email' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:user, :title => '')).not_to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:user, :name => '')).not_to be_valid
  end

  it 'is invalid without an email' do
    expect(build(:user, :email => '')).not_to be_valid
  end
end
