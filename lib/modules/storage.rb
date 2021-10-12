# frozen_string_literal: true

module IcodebreakerGem
  module Storage
    DATA_FILE = 'codebreakers.yml'
    STORAGE_PATH = './storage/'
   
    class << self
     
      def save_storage(game)
        create_storage
        games = load_storage
        games << game
        File.open(data_path, 'w') do |file|
          YAML.dump(games, file)
        end
      
      end
      def load_storage
        create_storage
        YAML.load(File.read(data_path)) || []
      end

      def sort_codebreakers
        load_storage.sort_by do |statistic|
          [statistic[:attempts_total], statistic[:attempts_used], statistic[:hints_used]]
        end
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
end
