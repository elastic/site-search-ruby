require 'spec_helper'

describe 'deprecated classes and methods' do
  context 'Elastic::SiteSearch::Easy' do
    it 'returns Elastic::SiteSearch::Client' do
      expect(Elastic::SiteSearch::Easy).to eq(Elastic::SiteSearch::Client)
    end
  end

  context 'Elastic::SiteSearch::Easy.configure' do
    it 'calls warn and calls Elastic::SiteSearch.configure' do
      expect(Elastic::SiteSearch::Client).to receive(:warn)
      Elastic::SiteSearch::Easy.configure do |config|
        config.api_key = 'got set'
      end

      expect(Elastic::SiteSearch.api_key).to eq('got set')
    end
  end
end
