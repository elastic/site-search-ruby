require 'spec_helper'

describe 'deprecated classes and methods' do
  context 'ElasticSiteSearch::Easy' do
    it 'returns ElasticSiteSearch::Client' do
      expect(ElasticSiteSearch::Easy).to eq(ElasticSiteSearch::Client)
    end
  end

  context 'ElasticSiteSearch::Easy.configure' do
    it 'calls warn and calls ElasticSiteSearch.configure' do
      expect(ElasticSiteSearch::Client).to receive(:warn)
      ElasticSiteSearch::Easy.configure do |config|
        config.api_key = 'got set'
      end

      expect(ElasticSiteSearch.api_key).to eq('got set')
    end
  end
end
