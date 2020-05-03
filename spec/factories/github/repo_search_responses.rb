FactoryBot.define do
  factory :github_repo_search_response, class: Github::RepoSearchResponse do
    skip_create
    initialize_with { new(attributes) }

    total_count { 100 }
    items { [] }
    error { nil }

    trait :with_error do
      error { 'Unknown' }
    end
  end
end
