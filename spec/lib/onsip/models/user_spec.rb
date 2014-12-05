require 'spec_helper'

describe OnSIP::User do

  before :each do
    OnSIP.connect('http://api.onsip.com')
    OnSIP.session = OnSIP::Session.new("IsEstablished" => "true")
  end

  describe "read" do
    body = {"Response"=>{"Context"=>{"Action"=>{"IsCompleted"=>"true"}, "Request"=>{"IsValid"=>"true", "DateTime"=>"2014-12-04T20:17:17+00:00", "Duration"=>"46", "Parameters"=>{"Parameter"=>[{"Name"=>"Action", "Value"=>"UserRead"}, {"Name"=>"Output", "Value"=>"json"}, {"Name"=>"SessionId", "Value"=>"bvb4thhuk1d7tb2bddf09teqr4"}, {"Name"=>"UserId", "Value"=>"260161"}]}}, "Session"=>{"IsEstablished"=>"true", "SessionId"=>"bvb4thhuk1d7tb2bddf09teqr4", "UserId"=>"212762", "Roles"=>{"Role"=>{"Name"=>"Account Admin"}}}}, "Result"=>{"UserRead"=>{"User"=>{"UserId"=>"260161", "OrganizationId"=>"30096", "AccountId"=>"27370", "Flags"=>"32", "Status"=>"disabled", "Domain"=>"sip.firertc.com", "Username"=>"test3_firertc", "Password"=>"**********", "AuthUsername"=>"test3_firertc", "Modified"=>"2014-11-24T19:24:03+00:00", "Created"=>"2014-11-03T19:30:08+00:00", "Ack911"=>"1970-01-01T00:00:00+00:00", "SurveyCompleted"=>"1970-01-01T00:00:00+00:00", "AckTrunkingTerms"=>"1970-01-01T00:00:00+00:00", "AckTrunkingE911"=>"1970-01-01T00:00:00+00:00", "AckHostedTerms"=>"1970-01-01T00:00:00+00:00", "AckHostedE911"=>"1970-01-01T00:00:00+00:00", "ExtendedDialing"=>"false", "PSTNForwarding"=>"false", "E911Provisioning"=>"false", "PSTNTrunking"=>"false", "FreePSTNTrunking"=>"false", "BusyLampField"=>"true", "Contact"=>{"Name"=>"test", "Organization"=>"IceHook Systems", "Address"=>"123 Main St", "City"=>"New York", "State"=>"NY", "Zipcode"=>"10000", "Country"=>"United States of America", "CountryId"=>"207", "Phone"=>"1-212-555-1212", "Email"=>"test@icehook.com", "Modified"=>"2014-11-03T19:30:08+00:00"}, "Roles"=>{"Role"=>{"Name"=>"User"}}}}}}}.to_json
    before { custom_stub(body, 'api', 'UserRead') }

    it "with valid id" do
      user = OnSIP::User.read('260161')
      expect(user.class).to eq OnSIP::User
    end

  end

end
