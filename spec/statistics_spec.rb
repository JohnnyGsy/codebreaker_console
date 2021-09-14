module IcodebreakerGem  
  RSpec.describe Statistics do
    let(:statistics) { Statistics.new("#{__dir__}/temp/statistics.yml") }
    let(:game) { Game.new }

    it 'add data of new game to statistics' do
      statistics.add_game(game)
      expect(statistics.games).to include(game.game_data)
    end

    it 'save statistics to yml' do
      statistics.add_game(game)
      statistics.save_games
      saved = File.read(statistics.file)
      sample = File.read("#{__dir__}/statistics_sample.yml")
      File.delete(statistics.file)
      expect(saved).to eq(sample)
    end

    it 'load games info from statistics file' do
      loaded = statistics.load_games("#{__dir__}/statistics_sample.yml")
      expect(loaded).to eq([game.game_data])
    end
  end
end