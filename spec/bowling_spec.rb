# frozen_string_literal: true
require 'bowling'

describe Bowling do
  let(:game) { Bowling.new }
  describe '#score' do
    context 'when the game starts' do
      it 'scores 0' do
        expect(game.score).to eq(0)
      end

      it 'has frames []' do
        expect(game.frames).to eq([])
      end
    end

    context 'when player scores without previous spare or strike' do
      it 'scores the sum of the pins that he put down' do
        pins_down = rand(11)
        game.throw(pins_down, 0)

        expect(game.score).to eq(pins_down)
        expect(game.frames).to eq([[pins_down, 0]])
      end
    end

    context 'when player throws twice' do
      it 'scores the sum of pins' do
        first_throw_hit = rand(6)
        second_throw_hit = rand(6)

        game.throw(first_throw_hit, second_throw_hit)

        expect(game.score).to eq(first_throw_hit + second_throw_hit)
      end
    end

    context 'when player throws a spare' do
      it 'scores the sum of the frame plus doubles of the first throw in next frame' do
        game.throw(9, 1)
        game.throw(3, 0)
        expect(game.score).to eq(16)
      end
    end


    context 'when player throws all spares through the game, there is a bonus throw after the last frame' do
      it 'scores the sum of the frame plus the first throw in next frame for each spare' do
        10.times { game.throw(5, 5) }
        game.throw(5)
        expect(game.score).to eq(150)
      end

      it 'scores the sum of the frame plus the first throw in next frame for each spare' do
        first_throw_hit = rand(10)
        second_throw_hit = 10 - first_throw_hit
        bonus_throw_hit = rand(10)
        expected_score = (first_throw_hit * 19) + (second_throw_hit * 10) + bonus_throw_hit

        10.times { game.throw(first_throw_hit, second_throw_hit) }
        game.throw(bonus_throw_hit)

        expect(game.score).to eq(expected_score)
      end
    end

    context 'when player throws a strike' do
      it 'scores the sum of the frame plus the first throw in next frame for each spare' do
        game.throw(10)
        game.throw(1, 2)
        expect(game.score).to eq(16)
      end
    end

    context 'when player throws all strikes through the game, there is a bonus throw after the last frame' do
      it 'scores the sum of the frame plus the next two throws for each strike' do
        10.times { game.throw(10) }
        game.throw(10)
        game.throw(10)
        expect(game.score).to eq(300)
      end

      it '..' do
        game.throw(8, 2)
        game.throw(7, 2)
        game.throw(10)
        game.throw(10)
        game.throw(6, 4)
        game.throw(6, 4)
        game.throw(10)
        game.throw(10)
        game.throw(9, 1)
        game.throw(3, 7)
        game.throw(10)
        expect(game.score).to eq(190)
      end
    end
  end
end
