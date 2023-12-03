class ComparisonCondition < Condition
  validates    :required_count, :comparison_operator, presence: true

  enum comparison_operator: {
      match_comparison: 0,
      lower_comparison: 1,
      higher_comparison: 2,
      higher_comparison_or_equal_to: 3,
      lower_comparison_or_equal_to: 4
    }

  def comparison_matches(value)
    case comparison_operator
      when "match_comparison"
        return value == required_count
      when "lower_comparison"
        return value < required_count
      when "higher_comparison"
        return value > required_count
      when "higher_comparison_or_equal_to"
        return value >= required_count
      when "lower_comparison_or_equal_to"
        return value <= required_count
    end
    return false
  end

end
