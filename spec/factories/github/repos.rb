FactoryBot.define do
  factory :github_repo, class: Github::Repo do
    skip_create
    initialize_with { new(attributes) }

    sequence(:name) { |i| "Repo #{i}" }
    sequence(:html_url) { |i| "https://github.com/user#{i}/repo#{i}" }
    sequence(:owner) { |i| { login: "user#{i}" } }

    description { '' }
    stargazers_count { 3 }
  end
end
