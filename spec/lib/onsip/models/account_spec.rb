require 'spec_helper'

describe OnSIP::Account do
  before :each do
    OnSIP.session = OnSIP::Session.new("IsEstablished" => "true")
  end

  describe "read" do

    success_body = {"Response"=>{"Context"=>{"Action"=>{"IsCompleted"=>"true"}, "Request"=>{"IsValid"=>"true", "DateTime"=>"2014-12-04T20:34:18+00:00", "Duration"=>"50", "Parameters"=>{"Parameter"=>[{"Name"=>"AccountId", "Value"=>"27370"}, {"Name"=>"Action", "Value"=>"AccountRead"}, {"Name"=>"Output", "Value"=>"json"}, {"Name"=>"SessionId", "Value"=>"1vflpm8sa25vt88o6nsl60lgi5"}]}}, "Session"=>{"IsEstablished"=>"true", "SessionId"=>"1vflpm8sa25vt88o6nsl60lgi5", "UserId"=>"212762", "Roles"=>{"Role"=>{"Name"=>"Account Admin"}}}}, "Result"=>{"AccountRead"=>{"Account"=>{"AccountId"=>"27370", "Receivable"=>"0.00", "Promocode"=>{}, "Productcode"=>"platform", "PerUserPricing"=>"false", "ResellerBilling"=>"false", "BalanceSeconds"=>"0", "EscrowSecondsUpdate"=>"0", "EscrowSecondsCredit"=>"0", "Balance"=>"00.00", "CreditLimit"=>"0.00", "Recharge"=>"false", "RechargeLevel"=>"0.00", "RechargeThreshold"=>"0.00", "Modified"=>"2014-12-03T19:04:34+00:00", "Created"=>"2014-03-24T14:15:44+00:00", "Contact"=>{"Name"=>"Bar  Foo", "Organization"=>"IceHook Systems", "Address"=>"123 Main St", "City"=>"New York", "State"=>"NY", "Zipcode"=>"100000", "Country"=>"United States of America", "CountryId"=>"207", "Phone"=>"1-212-555-1212", "Email"=>"test@icehook.com", "Modified"=>"2014-03-24T14:15:44+00:00"}, "CreditCard"=>{"CreditCardId"=>"12345", "AccountId"=>"54321", "CreditCardType"=>"3", "Name"=>"Foo Bar", "LastFour"=>"****", "Expiration"=>"01/2017", "Modified"=>"2014-10-15T18:07:36+00:00", "FirstName"=>"Foo", "LastName"=>"Bar", "Address"=>"123 Main St", "City"=>"New York", "State"=>"NY", "Zipcode"=>"10000", "CountryId"=>"207", "Phone"=>"1-212-555-1212", "IPAddress"=>"127.0.0.1"}}}}}}.to_json
    before { custom_stub(success_body, 'success', 'AccountRead') }

    it "with a valid id" do
      OnSIP.connect('http://success.onsip.com')
      account = OnSIP::Account.read('27370')
      expect(account.class).to eq OnSIP::Account
    end

    failed_body = {"Response"=>{"Context"=>{"Action"=>{"IsCompleted"=>"false", "Errors"=>{"Error"=>{"Code"=>"AccountAuthorization.Required", "Message"=>"Permission to perform the requested action has not been granted."}}}, "Request"=>{"IsValid"=>"true", "DateTime"=>"2014-12-04T21:36:21+00:00", "Duration"=>"41", "Parameters"=>{"Parameter"=>[{"Name"=>"AccountId", "Value"=>"12345"}, {"Name"=>"Action", "Value"=>"AccountRead"}, {"Name"=>"Output", "Value"=>"json"}, {"Name"=>"SessionId", "Value"=>"j3kmb4boemqnl6u1vsip210rp7"}]}}, "Session"=>{"IsEstablished"=>"true", "SessionId"=>"j3kmb4boemqnl6u1vsip210rp7", "UserId"=>"212762", "Roles"=>{"Role"=>{"Name"=>"Account Admin"}}}}}}.to_json
    before { custom_stub(failed_body, 'fail', 'AccountRead') }

    it "with an invalid id" do
      OnSIP.connect('http://fail.onsip.com')
      account = nil
      expect { account = OnSIP::Account.read('12345') }.to raise_error(OnSIP::Exceptions::OnSIPRequestError)
      expect(account).to be(nil)
    end

  end

  describe "add" do
  end

  describe "browse" do
  end

  describe "UserEditContact" do
  end

end
