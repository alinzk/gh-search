require 'rails_helper'

RSpec.describe 'GithubRepos', type: :request do
  describe 'GET /index' do
    context 'no search query' do
      it 'returns http success' do
        get '/github_repos'
        expect(response).to have_http_status(:success)
      end
    end

    context 'with search query' do
      let(:repo_search_response) { create(:github_repo_search_response) }

      before do
        expect_any_instance_of(GithubRepos::Search).to receive(:call).and_return(repo_search_response)
      end

      it 'returns http success' do
        get '/github_repos?q="test"'
        expect(response).to have_http_status(:success)
      end
    end
  end
end
