require 'rails_helper'

RSpec.describe 'GithubRepos', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/github_repos/index'
      expect(response).to have_http_status(:success)
    end
  end
end
