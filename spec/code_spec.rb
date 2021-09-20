# frozen_string_literal: true

module IcodebreakerGem
  RSpec.describe Code do
    it 'should contain the secret code' do
      code = Code.new('6543')
      expect(code.secret).to eq('6543')
    end

    it 'raise error on incorrect codes' do
      expect { Code.new('1234') }.not_to raise_error
      expect { Code.new('12345') }.to raise_error(ArgumentError)
      expect { Code.new('123') }.to raise_error(ArgumentError)
    end

    describe '#random' do
      it 'should generate random codes that matches pattern' do
        expect { Code.new }.not_to raise_error
      end
    end

    describe '#hint' do
      it 'gave one number of secret code' do
        code = Code.new
        expect(code.secret.include?(code.hint)).to be_truthy
      end
    end

    describe '#compare' do
      test_compare = {
        test1: {
          secret: '6543',
          guess: {
            '5643' => '++--',
            '6411' => '+-',
            '6544' => '+++',
            '3456' => '----',
            '6666' => '+',
            '2666' => '-',
            '2222' => ''
          }
        },
        test2: {
          secret: '6666',
          guess: {
            '1661' => '++',
            '1666' => '+++'
          }
        },
        test3: {
          secret: '1234',
          guess: {
            '3124' => '+---',
            '1524' => '++-',
            '1234' => '++++'
          }
        }
      }

      test_compare.each do |test_number, test_content|
        describe test_number.to_s do
          secret = test_content[:secret]
          code = Code.new(secret)
          test_content[:guess].each do |input, output|
            formatted_output = "'#{output}'".ljust(6)
            it "return #{formatted_output} if secret is #{secret} and guess is #{input}" do
              expect(code.compare(input)).to eq(output)
            end
          end
        end
      end
    end
  end
end
