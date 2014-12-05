require 'spec_helper'

describe OnSIP::UserAddress do
  before :each do
    OnSIP.connect('http://api.onsip.com')
    OnSIP.session = OnSIP::Session.new("IsEstablished" => "true")
  end

end
