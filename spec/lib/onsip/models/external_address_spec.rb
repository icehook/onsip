require 'spec_helper'

describe OnSIP::ExternalAddress do
  before :each do
    OnSIP.connect('http://api.onsip.com')
    OnSIP.session = OnSIP::Session.new("IsEstablished" => "true")
  end

  describe "browse" do
    body =  {"Response"=>{"Context"=>{"Action"=>{"IsCompleted"=>"true"}, "Request"=>{"IsValid"=>"true", "DateTime"=>"2014-12-05T20:13:59+00:00", "Duration"=>"17", "Parameters"=>{"Parameter"=>[{"Name"=>"Action", "Value"=>"ExternalAddressBrowse"}, {"Name"=>"Output", "Value"=>"json"}, {"Name"=>"SessionId", "Value"=>"lu2qftbuv883gu5iu5qofrva90"}, {"Name"=>"UserId", "Value"=>"266848"}, {"Name"=>"Limit", "Value"=>"20"}, {"Name"=>"Offset", "Value"=>"0"}, {"Name"=>"CalcFound", "Value"=>"true"}]}}, "Session"=>{"IsEstablished"=>"true", "SessionId"=>"lu2qftbuv883gu5iu5qofrva90", "UserId"=>"212762", "Roles"=>{"Role"=>{"Name"=>"Account Admin"}}}}, "Result"=>{"ExternalAddressBrowse"=>{"ExternalAddresses"=>{"@attributes"=>{"Limit"=>"20", "Offset"=>"0"}}}}}}.to_json
    before { custom_stub(body, 'api', 'ExternalAddressBrowse') }

    it "with valid id" do
      ea = OnSIP::ExternalAddress.browse({'UserId' => '266848'})
      expect(ea).to be_empty
    end
  end
end
