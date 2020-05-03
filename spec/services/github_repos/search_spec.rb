require 'rails_helper'

RSpec.describe GithubRepos::Search do
  subject { GithubRepos::Search.new('test') }
  let(:req_url) { 'https://api.github.com/search/repositories?q=test' }

  describe '#call' do
    context 'when no error' do
      let(:stub_repo) { '{ "name": "Repo 1", "description": "", "html_url": "https://example.com", "stargazers_count": 24, "owner": { "login": "user1" } }' } # rubocop:disable Layout/LineLength
      let(:stub_body) { "{ \"total_count\": 180, \"items\": [#{stub_repo}] }" }

      before do
        stub_request(:get, req_url).to_return(body: stub_body)
      end

      it 'parses http response and returns search results' do
        search_results = subject.call

        expect(search_results.total_count).to eq(180)
        expect(search_results.items.size).to eq(1)

        expect(search_results.items.first.name).to eq('Repo 1')
        expect(search_results.items.first.html_url).to eq('https://example.com')
        expect(search_results.items.first.owner.login).to eq('user1')
      end
    end

    context 'when error' do
      context 'rate limiting' do
        let(:stub_body) { '{ "message": "Rate limit exceeded!" }' }

        before do
          stub_request(:get, req_url).to_return(status: 403, body: stub_body)
        end

        it 'parses http response and sets correct error message' do
          search_results = subject.call

          expect(search_results.total_count).to eq(0)
          expect(search_results.items).to eq([])
          expect(search_results.error).to eq('Rate limit exceeded!')
        end
      end

      context 'unhandled error' do
        let(:stub_body) { 'Internal server error' }

        before do
          stub_request(:get, req_url).to_return(status: 500, body: stub_body)
        end

        it 'parses http response and sets error as unknown' do
          search_results = subject.call

          expect(search_results.total_count).to eq(0)
          expect(search_results.items).to eq([])
          expect(search_results.error).to eq('Unknown')
        end
      end
    end
  end
end
