class Bowling
  def initialize
    @score = []
  end

  def score
    unless @score[1].nil? || @score[2].nil?
      if @score[0] + @score[1] == 10
        @score << @score[2]
      end
    end
    @score.sum
  end

  def bowl(pins_hit)
    @score << pins_hit
  end
end
