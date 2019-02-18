# frozen_string_literal: true

class Bowling
  def initialize
    @total_score = 0
    @frames = []
  end

  def score
    @frames.each_with_index do |frame, i|
      extra_points = 0

      if has_previous_frame?(i) && frame_is_strike?(i - 1)
        if frame_is_strike?(i)
          extra_points = frame[0] + next_frame_for(i)[0] unless bonus_frame?(i - 1)
        else
          extra_points = frame.sum
        end
      elsif has_previous_frame?(i) && frame_is_spare?(i - 1)
        extra_points = frame[0]
      end

      @total_score += extra_points

      @total_score += frame.sum unless bonus_frame?(i)
    end

    @total_score
  end

  def throw(*frame)
    @frames << [frame[0], frame[1]].compact
  end

  def frames
    @frames
  end

  private

  def bonus_frame?(i)
    i > 9
  end

  def frame_is_strike?(i)
    @frames[i][0] == 10
  end

  def frame_is_spare?(i)
    @frames[i].sum == 10
  end

  def has_previous_frame?(frame_index)
    frame_index > 0
  end

  def next_frame_for(i)
    return [0] if @frames[i + 1].nil?

    @frames[i + 1]
  end
end
