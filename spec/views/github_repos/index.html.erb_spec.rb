require 'rails_helper'

RSpec.describe 'github_repos/index.html.erb', type: :view do
  let(:search_field) { 'input type="search"' }
  let(:submit_button) { 'button type="submit"' }

  before do
    assign(:search_query, nil)
    assign(:total_results, 0)
    assign(:repos, [])
    assign(:error, nil)
  end

  context 'with no query' do
    it 'renders search field' do
      render
      expect(rendered).to match(/#{search_field}/)
    end

    it 'renders submit button' do
      render
      expect(rendered).to match(/#{submit_button}/)
    end
  end

  context 'with search query' do
    before do
      assign(:search_query, 'test')
    end

    context 'with error' do
      before do
        assign(:error, 'Unknown')
      end

      it 'renders error message' do
        render
        expect(rendered).to match(/ERROR: Unknown/)
      end
    end

    context 'with two results' do
      let(:repos) { create_list(:github_repo, 2) }

      before do
        assign(:repos, repos)
        assign(:total_results, 10)
      end

      it 'renders 2 repos list' do
        render
        expect(rendered).to match(/Repo 1/)
        expect(rendered).to match(/Repo 2/)
      end
    end
  end
end
