require 'spec_helper'

describe 'Configuration' do
  context '.authenticated_url' do
    context 'with non-standard port number' do
      it 'sets the API key and endpoint' do
        Elastic::SiteSearch.authenticated_url = 'http://testkey:@localhost:1234/api/v1'
        expect(Elastic::SiteSearch.api_key).to eq('testkey')
        expect(Elastic::SiteSearch.endpoint).to eq('http://localhost:1234/api/v1/')
      end

      context 'with implicit port number' do
        it 'sets the API key and endpoint' do
          Elastic::SiteSearch.authenticated_url = 'https://testkey:@api.swiftype.com/api/v1'
          expect(Elastic::SiteSearch.api_key).to eq('testkey')
          expect(Elastic::SiteSearch.endpoint).to eq('https://api.swiftype.com/api/v1/')
        end
      end
    end
  end

  context '.endpoint' do
    context 'with a trailing /' do
      it 'adds / to the end of of the URL' do
        Elastic::SiteSearch.endpoint = 'https://api.swiftype.com/api/v1'
        expect(Elastic::SiteSearch.endpoint).to eq('https://api.swiftype.com/api/v1/')
      end
    end

    context 'with a trailing /' do
      it 'leaves the URL alone' do
        Elastic::SiteSearch.endpoint = 'https://api.swiftype.com/api/v1/'
        expect(Elastic::SiteSearch.endpoint).to eq('https://api.swiftype.com/api/v1/')
      end
    end
  end
end
