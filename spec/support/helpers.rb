module Helpers
  
  def custom_stub(body, uri_matcher, uri_params)
    stub_request(:get, Regexp.new("http://#{uri_matcher}.onsip.com/api?.*#{uri_params}.*"))
    .to_return({
      :body => body,
      :status => 200,
      :headers => { 'Content-Type' => 'application/json; charset=utf-8' }
      })
  end

end
