module GithubRepos
  class Search
    include HTTParty
    base_uri 'https://api.github.com/search'

    def initialize(query)
      @options = { query: { q: query } }
    end

    def call
      self.class.get('/repositories', @options).then do |response|
        case response.code
        when 200
          parsed_body = JSON.parse(response.body)
          Github::RepoSearchResponse.new(parsed_body)

        when 403
          parsed_body = begin
                          JSON.parse(response.body)
                        rescue StandardError
                          { 'message' => 'Unknown' }
                        end
          Github::RepoSearchResponse.new(
            error: parsed_body.fetch('message'),
            items: [],
            total_count: 0
          )

        else
          Github::RepoSearchResponse.new(error: 'Unknown', items: [], total_count: 0)
        end
      end
    end
  end
end
