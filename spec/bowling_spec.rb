require 'bowling'

describe Bowling do
  let(:game) { Bowling.new }
  describe '#score' do
   it 'can score 0 if player never hit a pin' do
     expect(game.score).to eq(0)
   end

   it 'can score 0 if player never hit a pin' do
     10.times { game.bowl(0) }
     expect(game.score).to eq(0)
   end

   it 'can score 20 if player scores 20 times 1' do
     20.times { game.bowl(1) }
     expect(game.score).to eq(20)
   end

   it 'can score 40 if player scores 20 times 2' do
     20.times { game.bowl(2) }
     expect(game.score).to eq(40)
   end

   it 'can score 17 if scored a spare 5,5 and 3,1,0,0...' do
     2.times { game.bowl(5) }
     game.bowl(3)
     game.bowl(1)
     16.times { game.bowl(0) }
     expect(game.score).to eq(17)
   end

   it 'can score multiple spares 5,5,3,1,5,5,3,1,0,0...' do
     2.times { game.bowl(5) }
     game.bowl(3)
     game.bowl(1)
     2.times { game.bowl(5) }
     game.bowl(3)
     game.bowl(1)
     12.times { game.bowl(0) }
     expect(game.score).to eq(34)
   end
  end
end
