# frozen_string_literal: true

module IcodebreakerGem
  module Storage
    DATA_FILE = 'codebreakers.yml'
    STORAGE_PATH = './storage/'
    def save(game)
      create_storage
      games = load
      games << game
      File.open(data_path, 'w') do |file|
        YAML.dump(games, file)
      end
    end

    def load
      create_storage
      YAML.load(File.read(data_path)) || []
    end

    def sort_codebreakers
    load.sort_by {}
  
    end
    private

    def data_path
      STORAGE_PATH + DATA_FILE
    end

    def create_storage
      Dir.mkdir(STORAGE_PATH) unless File.exist?(STORAGE_PATH)
      File.open(data_path, 'w') unless File.exist?(data_path)
    end
  end
end
