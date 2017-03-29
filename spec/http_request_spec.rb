require 'spec_helper'

describe 'Yt::HTTPRequest#run' do
  context 'given a valid GET request to a YouTube JSON API' do
    path = '/discovery/v1/apis/youtube/v3/rest'
    headers = {'User-Agent' => 'Yt::HTTPRequest'}
    params = {verbose: 1}
    request = Yt::HTTPRequest.new path: path, headers: headers, params: params

    it 'returns the HTTP response with the JSON-parsed body' do
      response = request.run
      expect(response).to be_a Net::HTTPOK
      expect(response.body).to be_a Hash
    end
  end

  context 'given a invalid GET request to a YouTube JSON API' do
    path = '/discovery/v1/apis/youtube/v3/unknown-endpoint'
    body = {token: :unknown}
    request = Yt::HTTPRequest.new path: path, method: :post, body: body

    it 'raises an HTTPError' do
      expect{request.run}.to raise_error Yt::HTTPError, 'Error: Not Found'
    end
  end
end
