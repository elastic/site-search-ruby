require 'spec_helper'

# These tests use real network connections to test the SSL
# support. Since a real API key is not used, the success condition is
# that the connection was made and the approriate error message is
# returned from the API
describe 'SSL support' do
  let(:client) { ElasticSiteSearch::Client.new }

  context 'when the endpoint is configured to use SSL' do
    it 'connects successfully' do
      ElasticSiteSearch.endpoint = 'https://api.swiftype.com/api/v1/'

      VCR.turned_off do
        WebMock.allow_net_connect!
        expect do
          client.search('site-search-api-example', 'test')
        end.to raise_error(ElasticSiteSearch::InvalidCredentials)
      end
    end
  end

  context 'when the endpoint is configured not to use SSL' do
    it 'connects successfully' do
      ElasticSiteSearch.endpoint = 'http://api.swiftype.com/api/v1/'
      VCR.turned_off do
        WebMock.allow_net_connect!
        expect do
          client.search('site-search-api-example', 'test')
        end.to raise_error(ElasticSiteSearch::InvalidCredentials)
      end
    end
  end
end
