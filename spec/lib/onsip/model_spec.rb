require 'spec_helper'

describe OnSIP::Model do
  before :each do

  end

  describe "ClassMethods" do
    it "can merge params" do
      params = OnSIP::Model.merge_params({:test => {:k => 'Test', :v => 123}}, {:test => 456})
      expect(params).to eq({'Test' => 456})
    end
  end

end
