require 'spec_helper'

describe 'platform user API' do
  let(:client) { ElasticSiteSearch::Client.new }

  context 'authentication' do
    it 'succeeds with api_key and correct client_id and client_secret' do
      ElasticSiteSearch.api_key = 'hello'
      ElasticSiteSearch.platform_client_id = '0d94f7cf2bd1e65a7e1f9f929d1bcb2b248af69b8112d24484e87014125538f8'
      ElasticSiteSearch.platform_client_secret = 'f600fb0b16b516cbb9b9f0eeb60f3b35f685b5ec4a94694ae57b5bbb8860f240'

      VCR.use_cassette('list_users') do
        expect do
          client.users
        end.to_not raise_error
      end
    end

    it 'fails without api_key' do
      ElasticSiteSearch.platform_client_id = '0d94f7cf2bd1e65a7e1f9f929d1bcb2b248af69b8112d24484e87014125538f8'
      ElasticSiteSearch.platform_client_secret = 'f600fb0b16b516cbb9b9f0eeb60f3b35f685b5ec4a94694ae57b5bbb8860f240'

      VCR.use_cassette('users_no_api_key') do
        expect do
          client.users
        end.to raise_error
      end
    end

    it 'fails with missing client_id and client_secret' do
      ElasticSiteSearch.api_key = 'hello'

      VCR.use_cassette('users_no_client_id_or_secret') do
        expect do
          client.users
        end.to raise_error
      end
    end

    it 'fails with incorrect client_secret' do
      ElasticSiteSearch.platform_client_id = '0d94f7cf2bd1e65a7e1f9f929d1bcb2b248af69b8112d24484e87014125538f8'
      ElasticSiteSearch.platform_client_secret = 'wrong'

      VCR.use_cassette('users_client_secret_incorrect') do
        expect do
          client.users
        end.to raise_error
      end
    end
  end

  context 'with proper authentication' do
    before :each do
      ElasticSiteSearch.api_key = 'hello'
      ElasticSiteSearch.platform_client_id = '0d94f7cf2bd1e65a7e1f9f929d1bcb2b248af69b8112d24484e87014125538f8'
      ElasticSiteSearch.platform_client_secret = 'f600fb0b16b516cbb9b9f0eeb60f3b35f685b5ec4a94694ae57b5bbb8860f240'
    end

    context 'creating a user' do
      it 'returns a Hash with user info' do
        VCR.use_cassette('create_user') do
          user = client.create_user
          expect(user).to have_key('id')
          expect(user).to have_key('access_token')
        end
      end
    end

    context 'listing users' do
      it 'returns the first page of users' do
        VCR.use_cassette('list_users') do
          users = client.users
          expect(users.length).to eq(3)
        end
      end

      it 'returns an empty list of users once you page past the end' do
        VCR.use_cassette('list_users_with_pagination') do
          users = client.users(:page => 2)
          expect(users.length).to eq(0)
        end
      end
    end

    context 'showing a user' do
      it 'returns a Hash with user info' do
        VCR.use_cassette('show_user') do
          user = client.user('5230b8c82ed960ba2000001d')
          expect(user['id']).to eq('5230b8c82ed960ba2000001d')
          expect(user['access_token']).to eq('0381294b7ef41db44fba20aad86a52d294b9fae67a26e85139d323eb78106706')
        end
      end
    end
  end
end
