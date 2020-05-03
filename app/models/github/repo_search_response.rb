module Github
  class RepoSearchResponse < Dry::Struct
    transform_keys(&:to_sym)

    attribute :total_count, Types::Integer
    attribute :items, Types::Strict::Array.of(Repo)

    attribute? :error, Types::String.optional
  end
end
