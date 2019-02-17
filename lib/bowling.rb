class Bowling
  def initialize
    @total_score = 0
    @frames = []
  end

  def score
    @frames.each_with_index do |frame, i|
      extra_points = 0

      if has_previous_frame?(i) && frame_is_strike?(i-1)
        if frame_is_strike?(i)
          extra_points = frame[0] + next_frame_for(i)[0] unless is_bonus_frame?(i)
        else
          extra_points = frame.sum
        end
      elsif has_previous_frame?(i) && frame_is_spare?(i-1)
        extra_points = frame[0]
      end

      @total_score += frame.sum + extra_points
    end

    substrakt_bonus_frames
    @total_score
  end

  def throw(*frame)
      @frames << [frame[0], frame[1]].compact
  end

  def frames
    @frames
  end

  private

  def frame_is_strike?(i)
    if @frames[i].sum == 10 && @frames[i].length == 1
      return true
    end
    false
  end

  def frame_is_spare?(i)
    @frames[i].sum == 10
  end

  def has_previous_frame?(frame_index)
    frame_index > 0
  end

  def is_bonus_frame?(i)
    i > 10
  end

  def substrakt_bonus_frames
    @total_score -= @frames[10].sum unless @frames[10].nil?
    @total_score -= @frames[11].sum unless @frames[11].nil?
  end

  def next_frame_for(i)
    return [0] if @frames[i+1].nil?
    @frames[i+1]
  end
end
