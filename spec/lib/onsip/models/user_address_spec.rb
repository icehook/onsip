require 'spec_helper'

describe OnSIP::UserAddress do
  before :each do
    OnSIP.connect('http://api.onsip.com')
    OnSIP.session = OnSIP::Session.new("IsEstablished" => "true")
  end

  describe "browse" do
    body = {"Response"=>{"Context"=>{"Action"=>{"IsCompleted"=>"true"}, "Request"=>{"IsValid"=>"true", "DateTime"=>"2014-12-05T20:02:37+00:00", "Duration"=>"20", "Parameters"=>{"Parameter"=>[{"Name"=>"Action", "Value"=>"UserAddressBrowse"}, {"Name"=>"Output", "Value"=>"json"}, {"Name"=>"SessionId", "Value"=>"lu2qftbuv883gu5iu5qofrva90"}, {"Name"=>"UserId", "Value"=>"252683"}, {"Name"=>"Limit", "Value"=>"20"}, {"Name"=>"Offset", "Value"=>"0"}, {"Name"=>"CalcFound", "Value"=>"true"}]}}, "Session"=>{"IsEstablished"=>"true", "SessionId"=>"lu2qftbuv883gu5iu5qofrva90", "UserId"=>"212762", "Roles"=>{"Role"=>{"Name"=>"Account Admin"}}}}, "Result"=>{"UserAddressBrowse"=>{"UserAddresses"=>{"@attributes"=>{"Limit"=>"20", "Offset"=>"0", "Found"=>"1"}, "UserAddress"=>{"UserId"=>"252683", "AuthUsername"=>"bharris_firertc", "AuthPassword"=>"eUDkEdMnuqiWr2jA", "Timeout"=>"20", "E911LocationId"=>{}, "DoNotDisturb"=>"false", "Address"=>{"AddressId"=>"787282", "Username"=>"bharris", "Domain"=>"sip.firertc.com", "Type"=>"user", "Name"=>"Brendon Harris", "Modified"=>"2014-09-30T18:32:13+00:00", "Created"=>"2014-09-30T18:32:13+00:00", "CplText"=>"<cpl xmlns=\"urn:ietf:params:xml:ns:cpl\"/>"}}}}}}}.to_json
    before { custom_stub(body, 'api', 'UserAddressBrowse') }

    it "with valid id" do
      ua = OnSIP::UserAddress.browse({'UserId' => '266848'})
      expect(ua).to include OnSIP::UserAddress
    end
  end
end
