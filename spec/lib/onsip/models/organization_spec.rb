require 'spec_helper'

describe OnSIP::Organization do
  before :each do
    OnSIP.connect('http://api.onsip.com')
    OnSIP.session = OnSIP::Session.new("IsEstablished" => "true")
  end

  describe "read" do
    body = {"Response"=>{"Context"=>{"Action"=>{"IsCompleted"=>"true"}, "Request"=>{"IsValid"=>"true", "DateTime"=>"2014-12-05T19:13:17+00:00", "Duration"=>"24", "Parameters"=>{"Parameter"=>[{"Name"=>"Action", "Value"=>"OrganizationRead"}, {"Name"=>"OrganizationId", "Value"=>"30096"}, {"Name"=>"Output", "Value"=>"json"}, {"Name"=>"SessionId", "Value"=>"7kq545de3001r1h2vfmrh15ag3"}]}}, "Session"=>{"IsEstablished"=>"true", "SessionId"=>"7kq545de3001r1h2vfmrh15ag3", "UserId"=>"212762", "Roles"=>{"Role"=>{"Name"=>"Account Admin"}}}}, "Result"=>{"OrganizationRead"=>{"Organization"=>{"OrganizationId"=>"30096", "AccountId"=>"27370", "Service"=>"platform", "Domain"=>"sip.firertc.com", "CallerId"=>{}, "CallerIdName"=>{}, "CallerIdNumber"=>{}, "Status"=>"enabled", "ExtendedDialing"=>"false", "E911Provisioning"=>"false", "BusyLampField"=>"true", "Authenticated"=>"true", "RegistrationLimit"=>"5000", "Modified"=>"2014-11-24T19:24:03+00:00", "Created"=>"2014-03-24T14:15:44+00:00", "Contact"=>{"Name"=>"Foo  Bar", "Organization"=>"IceHook Systems", "Address"=>"123 Main st", "City"=>"New York", "State"=>"NY", "Zipcode"=>"10000", "Country"=>"United States of America", "CountryId"=>"207", "Phone"=>"1-212-222-6263", "Email"=>"foo@example.com", "Modified"=>"2014-03-24T14:15:44+00:00"}}}}}}.to_json
    before { custom_stub(body, 'api', 'OrganizationRead') }

    it "with valid id" do
      org = OnSIP::Organization.read('30096')
      expect(org.class).to eq OnSIP::Organization
    end
  end
end
