require 'spec_helper'

describe OnSIP::User do

  before :each do
    OnSIP.session = OnSIP::Session.new("IsEstablished" => "true")
  end

  describe "read" do
    read_body = {"Response"=>{"Context"=>{"Action"=>{"IsCompleted"=>"true"}, "Request"=>{"IsValid"=>"true", "DateTime"=>"2014-12-04T20:17:17+00:00", "Duration"=>"46", "Parameters"=>{"Parameter"=>[{"Name"=>"Action", "Value"=>"UserRead"}, {"Name"=>"Output", "Value"=>"json"}, {"Name"=>"SessionId", "Value"=>"bvb4thhuk1d7tb2bddf09teqr4"}, {"Name"=>"UserId", "Value"=>"260161"}]}}, "Session"=>{"IsEstablished"=>"true", "SessionId"=>"bvb4thhuk1d7tb2bddf09teqr4", "UserId"=>"212762", "Roles"=>{"Role"=>{"Name"=>"Account Admin"}}}}, "Result"=>{"UserRead"=>{"User"=>{"UserId"=>"260161", "OrganizationId"=>"30096", "AccountId"=>"27370", "Flags"=>"32", "Status"=>"disabled", "Domain"=>"sip.firertc.com", "Username"=>"test3_firertc", "Password"=>"**********", "AuthUsername"=>"test3_firertc", "Modified"=>"2014-11-24T19:24:03+00:00", "Created"=>"2014-11-03T19:30:08+00:00", "Ack911"=>"1970-01-01T00:00:00+00:00", "SurveyCompleted"=>"1970-01-01T00:00:00+00:00", "AckTrunkingTerms"=>"1970-01-01T00:00:00+00:00", "AckTrunkingE911"=>"1970-01-01T00:00:00+00:00", "AckHostedTerms"=>"1970-01-01T00:00:00+00:00", "AckHostedE911"=>"1970-01-01T00:00:00+00:00", "ExtendedDialing"=>"false", "PSTNForwarding"=>"false", "E911Provisioning"=>"false", "PSTNTrunking"=>"false", "FreePSTNTrunking"=>"false", "BusyLampField"=>"true", "Contact"=>{"Name"=>"test", "Organization"=>"IceHook Systems", "Address"=>"123 Main St", "City"=>"New York", "State"=>"NY", "Zipcode"=>"10000", "Country"=>"United States of America", "CountryId"=>"207", "Phone"=>"1-212-555-1212", "Email"=>"test@icehook.com", "Modified"=>"2014-11-03T19:30:08+00:00"}, "Roles"=>{"Role"=>{"Name"=>"User"}}}}}}}.to_json
    before { custom_stub(read_body, 'read', 'UserRead') }

    it "with valid id" do
      OnSIP.connect('http://read.onsip.com')
      user = OnSIP::User.read('260161')
      expect(user.class).to eq OnSIP::User
    end

  end

  describe "add" do
    fail_body = {"Response"=> {"Context"=> {"Action"=>{"IsCompleted"=>"false"}, "Request"=> {"IsValid"=>"false", "DateTime"=>"2015-06-01T18:45:16+00:00", "Duration"=>"38", "Parameters"=> {"Parameter"=> [{"Name"=>"Action", "Value"=>"UserAdd"}, {"Name"=>"AuthUsername", "Value"=>"foobar888_firertc"}, {"Name"=>"Domain", "Value"=>"sip.devel.firertc.com"}, {"Name"=>"Email", "Value"=>"onsip+foobar888@icehook.com"}, {"Name"=>"Name", "Value"=>{}}, {"Name"=>"OrganizationId", "Value"=>"42975"}, {"Name"=>"Output", "Value"=>"json"}, {"Name"=>"Password", "Value"=>"******"}, {"Name"=>"PasswordConfirm", "Value"=>"******"}, {"Name"=>"SessionId", "Value"=>"ak7gllnq56e0soiebn23h9rlu3"}, {"Name"=>"Username", "Value"=>"foobar888"}]}, "Errors"=>{"Error"=>{"Parameter"=>"Username", "Code"=>"Address.Unavailable", "Message"=>"This address is already in use, is reserved, or is otherwise unavailable for use."}}}, "Session"=>{"IsEstablished"=>"true", "SessionId"=>"ak7gllnq56e0soiebn23h9rlu3", "UserId"=>"282881", "Roles"=>{"Role"=>{"Name"=>"Account Admin"}}}}}}.to_json
    add_body = {"Response"=>{"Context"=>{"Action"=>{ "IsCompleted"=>"true" },"Request"=>{"IsValid"=>"true","DateTime"=>"2014-04-21T16:19:55+00:00","Duration"=>"165","Parameters"=>{"Parameter"=>[{"Name"=>"Action","Value"=>"UserAdd"},{"Name"=>"SessionId","Value"=>"thqqva0i6jp3ea1ved17shcdg7"},{"Name"=>"OrganizationId","Value"=>"25018"},{"Name"=>"Username","Value"=>"docs"},{"Name"=>"Domain","Value"=>"example.onsip.com"},{"Name"=>"Name","Value"=>"Docs"},{"Name"=>"Email","Value"=>"docs@example.onsip.com"},{"Name"=>"AuthUsername","Value"=>"example"},{"Name"=>"Password","Value"=>"******"},{"Name"=>"PasswordConfirm","Value"=>"******"},{"Name"=>"Role","Value"=>"User"}]}},"Session"=>{"IsEstablished"=>"true","SessionId"=>"thqqva0i6jp3ea1ved17shcdg7","UserId"=>"152255","Roles"=>{"Role"=>{ "Name"=>"Account Admin" }}}},"Result"=>{"UserAdd"=>{"User"=>{"UserId"=>"218339","OrganizationId"=>"25018","AccountId"=>"22543","Flags"=>"0","Status"=>"enabled","Domain"=>"example.onsip.com","Username"=>"example","Password"=>"QPD2MLQhdaHB2hBW","AuthUsername"=>"example","Modified"=>"2014-04-21T16:19:55+00:00","Created"=>"2014-04-21T16:19:55+00:00","Ack911"=>"1970-01-01T00:00:00+00:00","SurveyCompleted"=>"1970-01-01T00:00:00+00:00","AckTrunkingTerms"=>"1970-01-01T00:00:00+00:00","AckTrunkingE911"=>"1970-01-01T00:00:00+00:00","AckHostedTerms"=>"1970-01-01T00:00:00+00:00","AckHostedE911"=>"1970-01-01T00:00:00+00:00","ExtendedDialing"=>"false","PSTNForwarding"=>"false","E911Provisioning"=>"false","PSTNTrunking"=>"false","FreePSTNTrunking"=>"false","BusyLampField"=>"false","Contact"=>{"Name"=>"Docs","Organization"=>"example","Address"=>"55 broad street","City"=>"Brooklyn","State"=>"NY","Zipcode"=>"11201","Country"=>"United States of America","CountryId"=>"207","Phone"=>"1-555-555-5555","Email"=>"docs@example.onsip.com","Modified"=>"2014-04-21T16:19:55+00:00"},"Roles"=>{"Role"=>{ "Name"=>"User" }}}}}}}.to_json
    before {
      stub_request(:get, Regexp.new("http://addfail.onsip.com/api?.*UserAdd.*"))
      .to_return({
        :body => fail_body,
        :status => 200,
        :headers => { 'Content-Type' => 'application/json; charset=utf-8' }
        })

      stub_request(:get, Regexp.new("http://add.onsip.com/api?.*UserAdd.*"))
      .to_return({
        :body => add_body,
        :status => 200,
        :headers => { 'Content-Type' => 'application/json; charset=utf-8' }
        })
    }

    it "should add with valid orgnization and attrs" do
      OnSIP.connect('http://add.onsip.com')
      org = OnSIP::Organization.new
      attrs = {
        'SessionId' => 'thqqva0i6jp3ea1ved17shcdg7',
        'OrganizationId' => '2501',
        'Username' => 'docs',
        'Domain' => 'example.onsip.com',
        'Name' => 'Docs',
        'Email' => 'docs@example.onsip.com',
        'AuthUsername' => 'example',
        'Password' => 'mysuperpassword',
        'PasswordConfirm' => 'mysuperpassword'
      }
      user = OnSIP::User.add(org, attrs)
      expect(user.class).to eq OnSIP::User
    end

    it "should not add without valid orgnization and attrs" do
      OnSIP.connect('http://addfail.onsip.com')
      org = OnSIP::Organization.new
      attrs = {
        'SessionId' => 'thqqva0i6jp3ea1ved17shcdg7',
        'OrganizationId' => '2501',
        'Username' => 'docs',
        'Domain' => 'example.onsip.com',
        'Name' => 'Docs',
        'Email' => 'docs@example.onsip.com',
        'AuthUsername' => 'example',
        'Password' => 'mysuperpassword',
        'PasswordConfirm' => 'mysuperpassword'
      }
      expect { OnSIP::User.add(org, attrs) }.to raise_error(OnSIP::Exceptions::OnSIPRequestError) 

    end
  end

end
