class GithubReposController < ApplicationController
  def index
    search_results = GithubRepos::Search.new(search_query).call if search_query

    @total_results = search_results&.total_count || 0
    @repos = search_results&.items || []
    @error = search_results&.error
  end

  private

  def search_query
    @search_query ||= params[:q]
  end
end
