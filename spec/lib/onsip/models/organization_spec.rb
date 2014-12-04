require 'spec_helper'

describe OnSIP::Organization do
  before :each do

    body = {"Response"=>{"Context"=>{"Action"=>{"IsCompleted"=>"true"}, "Request"=>{"IsValid"=>"true", "DateTime"=>"2014-12-04T17:39:53+00:00", "Duration"=>"30", "Parameters"=>{"Parameter"=>[{"Name"=>"Action", "Value"=>"SessionCreate"}, {"Name"=>"Output", "Value"=>"json"}, {"Name"=>"Password", "Value"=>"******"}, {"Name"=>"Username", "Value"=>"icehook"}]}}, "Session"=>{"IsEstablished"=>"true", "SessionId"=>"j2vtu1bk7rsdpklofplu07ocq1", "UserId"=>"212762", "Roles"=>{"Role"=>{"Name"=>"Account Admin"}}}}, "Result"=>{"SessionCreate"=>{}}}}.to_json
    stub_request(:get, Regexp.new('http://api.onsip.com/api?.*OrganizationAdd.*'))
    .to_return({
      :body => body,
      :status => 200,
      :headers => { 'Content-Type' => 'application/json; charset=utf-8' }
    })
    OnSIP.connect('http://api.onsip.com')
  end

end
