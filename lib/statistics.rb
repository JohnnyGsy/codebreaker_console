module IcodebreakerGem
  class Statistics
    include Storage

    attr_reader :games, :file
    def initialize(path)
      @file = path
      @games = load_games
    end

    def add_game(game)
      @games << game.game_data
    end

    def save_games(path = @file)
      @games.sort_by! { |game| game[:rating] }
      data = { games: @games }
      save(data, path)
    end

    def load_games(path = @file)
      data = load(path) if File.exist?(path)
      return [] unless data

      data[:games]
    end
  end
end