module Github
  class Repo < Dry::Struct
    transform_keys(&:to_sym)

    attribute :name, Types::String
    attribute :description, Types::String.optional
    attribute :html_url, Types::String
    attribute :stargazers_count, Types::Integer

    attribute :owner do
      attribute :login, Types::String
    end
  end
end
