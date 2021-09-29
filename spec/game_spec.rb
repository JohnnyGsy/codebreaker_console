# frozen_string_literal: true

module IcodebreakerGem
  RSpec.describe Game do
    describe '#username' do
      it 'needs formatted username ' do
        expect { Game.new('') }.to raise_error(ArgumentError)
        expect { Game.new('ThisIsWayTooLongUserName') }.to raise_error(ArgumentError)
      end
    end

    describe '#difficulties' do
      it 'forbid incorrect difficulties' do
        expect { Game.new('Username', :easy) }.not_to raise_error
        expect { Game.new('Username', :medium) }.not_to raise_error
        expect { Game.new('Username', :hell) }.not_to raise_error

        expect { Game.new('Username', 'easy') }.not_to raise_error
        expect { Game.new('Username', 'medium') }.not_to raise_error
        expect { Game.new('Username', 'hell') }.not_to raise_error

        expect { Game.new('Username', :some_other_difficulty) }.to raise_error(ArgumentError, 'No such difficulty')
        expect { Game.new('Username', nil) }.to raise_error(ArgumentError, 'No such difficulty')
        expect { Game.new('Username', 123) }.to raise_error(ArgumentError, 'No such difficulty')
      end

      it "has 'easy' difficulty" do
        easy_game = Game.new('UserName', :easy)
        expect(easy_game.name).to eq('UserName')
        expect(easy_game.difficulty).to eq(:easy)

        expect(easy_game.attempts_total).to eq(15)
        expect(easy_game.hints_total).to eq(2)
      end

      it "has 'medium' difficulty" do
        medium_game = Game.new('UserName', :medium)
        expect(medium_game.name).to eq('UserName')
        expect(medium_game.difficulty).to eq(:medium)

        expect(medium_game.attempts_total).to eq(10)
        expect(medium_game.hints_total).to eq(1)
      end

      it "has 'hell' difficulty" do
        hell_game = Game.new('UserName', :hell)
        expect(hell_game.name).to eq('UserName')
        expect(hell_game.difficulty).to eq(:hell)

        expect(hell_game.attempts_total).to eq(5)
        expect(hell_game.hints_total).to eq(1)
      end

      it 'has zero used attempts and hints by default' do
        game = Game.new
        expect(game.attempts_used).to eq(0)
        expect(game.hints_used).to eq(0)
      end
    end

    describe '#gameplay' do
      it 'have play status' do
        game = Game.new
        expect(STATUS).to eq(%i[go_on over])
        expect(RESULT).to eq(%i[win lose])
        expect(game.status).to be(:go_on)
        expect(game.result).to be_nil
      end

      let(:test_easy_win) do
        {
          secret: '6543',
          guess: {
            '2222' => '',
            '2666' => '-',
            '6666' => '+',
            '6411' => '+-',
            '3456' => '----',
            '5643' => '++--',
            '6543' => '++++'
          }
        }
      end
      it 'have win condition' do
        game = Game.new('Secret', :easy, test_easy_win[:secret])
        test_easy_win[:guess].each do |code, answer|
          expect(game.attempt(code)).to eq(answer)
        end
        expect(game.attempts_used).to eq(7)
        expect(game.status).to be(:over)
        expect(game.result).to be(:win)
      end

      let(:test_hell_lose) do
        {
          secret: '6543',
          guess: {
            '2222' => '',
            '2666' => '-',
            '6666' => '+',
            '6411' => '+-',
            '3456' => '----'
          }
        }
      end
      it 'have lose condition' do
        game = Game.new('Secret', :hell, test_hell_lose[:secret])
        test_hell_lose[:guess].each do |code, answer|
          expect(game.attempt(code)).to eq(answer)
        end
        expect(game.attempts_used).to eq(5)
        expect(game.status).to be(:over)
        expect(game.result).to be(:lose)
      end
    end

    describe '#hints' do
      it 'have limited amount of hints' do
        DIFFICULTIES.each do |level|
          game = Game.new('HintUser', level.first, 1234)
          game.hints_total.times do
            expect(game.hint).to match(/^[0-9]$/)
          end
          expect(game.hint).to eq('No hints left.')
        end
      end
    end
    describe '#load_storage' do
      it 'returns empty array if file not exist' do
        expect(Storage.load_storage).to be_empty
      end
    end
  end
end
