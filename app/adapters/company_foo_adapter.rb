class CompanyFooAdapter < ApplicationAdapter
  def initialize(params)
    @user = User.find(params[:user_id]) rescue nil
  end

  def submit_request
    return nil unless @user
    
    xml      = BuildUserXmlService.new(:id => @user.id, :adapter => 'CompanyFoo').call
    response = HTTParty.post(ENV['COMPANY_FOO_ENDPOINT'], :body => xml, :headers => {'Content-Type' => 'text/xml'})
  end
end
